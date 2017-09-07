module SabredavClient
  module XmlRequestBuilder
    class PROPFINDCalendarUrl < Base
      attr_reader :properties

      PROPERTIES = {
        calendar_home_set: :c,
      }

      def initialize(properties:)
        @properties = properties
        super()
      end

      def to_xml
        xml.d :propfind, C_NAMESPACES do
          xml.d :prop do
            build_properties
          end
        end
      end

      def build_properties
        properties.each do |property|
          raise SabredavClient::Errors::PropertyNotSupportedError, "Known properties are #{PROPERTIES}" unless PROPERTIES.keys.include?(property)

          readable_property = property.to_s.gsub('_', '-').to_sym

          case PROPERTIES[property]
          when :c
            xml.c readable_property
          when :cs
            xml.cs readable_property
          end
        end
      end
    end
  end
end
