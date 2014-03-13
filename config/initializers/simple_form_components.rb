module SimpleForm
  module Components

    module Icons
      def icon
        return icon_class unless options[:icon].nil?
      end

      def icon_class
        icon_tag = template.content_tag(:i, '', class: options[:icon])
        icon_tag
      end
    end

    module Tooltips
      def tooltip
        unless tooltip_text.nil?
          input_html_options[:rel] ||= 'tooltip'
          input_html_options['data-toggle'] ||= 'tooltip'
          input_html_options['data-placement'] ||= tooltip_position
          input_html_options['data-trigger'] ||= 'focus'
          input_html_options['data-original-title'] ||= tooltip_text
          nil
        end
      end

      def tooltip_text
        tooltip = options[:tooltip]
        tooltip.is_a?(String) ? tooltip : tooltip.is_a?(Array) ? tooltip[1] : nil
      end

      def tooltip_position
        tooltip = options[:tooltip]
        tooltip.is_a?(Array) ? tooltip[0] : "right"
      end
    end

  end

end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Icons)

