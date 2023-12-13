# frozen_string_literal: true

require "libxml"
require_relative "libxml_enumparse/version"

module LibXMLEnumparse
  class Error < StandardError; end

  class Parser
    class EnumCallbacks
      include ::LibXML::XML::SaxParser::Callbacks

      def initialize(tag)
        @tag = tag
        @buf = StringIO.new
        @layer = 0
      end

      def on_start_element(element, attributes)
        @layer += 1 if element == @tag
        return if @layer.zero?

        if attributes.empty?
          @buf << "<#{element}>"
        else
          attr_pairs = attributes.map do |k, v|
            "#{k}=\"#{v.gsub('"', "%22").gsub("&", "%26")}\""
          end.join(" ")
          @buf << "<#{element} #{attr_pairs}>"
        end
      end

      def on_characters(chars)
        @buf << "#{CGI.escapeHTML(chars)}\n" if @layer.positive?
      end

      def on_end_element(element)
        return if @buf.length.zero?

        @layer -= 1 if element == @tag
        @buf << "</#{element}>\n" if @layer.positive?
        if @layer.zero? && element == @tag
          @buf << "</#{element}>\n"
          Fiber.yield(@buf.string)
          @buf = StringIO.new
        end
      end
    end

    #
    # コンストラクタ
    #
    # @param [String] file_path XMLファイルのパス
    # @param [String] tag XMLファイルから分割して切り出すタグ
    #
    def initialize(file_path, tag)
      raise ArgumentError, "file_path is not set." unless file_path.is_a?(String)
      raise ArgumentError, "tag is not set." unless tag.is_a?(String)

      @fiber = Fiber.new do
        parser = LibXML::XML::SaxParser.file(file_path)
        parser.callbacks = EnumCallbacks.new(tag)
        parser.parse
        Fiber.yield(nil)
      end
    end

    #
    # 指定された tag の XMLエレメントを順次処理する Enumerator オブジェクトを返します
    #
    # @return [Enumerator] XMLエレメントを順次処理する Enumerator オブジェクト
    #
    def enumerator
      Enumerator.new do |y|
        loop do
          res = @fiber.resume
          break unless res

          y << res
        end
      end
    end
  end
end
