require 'active_support/core_ext'
require 'nicoapi/base'


module NicoAPI
  class TagSearch
    include NicoAPI::Base

    def set(tag: tag, sort: sort, order: order)
      @dynamic_segment = tag
      @params_array = params_array(sort, order)
    end

    private
    def host
      'www.nicovideo.jp'
    end

    def static_segment
      'tag'
    end

    def params_array(sort, order)
      array = []

      array.push sort_param(sort)
      array.push order_param(order)
      array.push "rss=2.0"

      array
    end

    def format
      "rss=2.0"
    end

    def sort_param(sort)
      sort_string = case sort
      when :commented_at then nil
      when :view_count   then 'v'
      when :comment_num  then 'r'
      when :mylist_count then 'm'
      when :published_at then 'f'
      when :length       then 'l'
      else nil
      end

      sort_string.present? ? "sort=#{sort_string}" : ''
    end

    def order_param(order)
      order_string = case order
      when :asc  then 'order=a'
      when :desc  then 'order=d'
      else nil
      end

      order_string.present? ? 'order=a' : ''
    end
  end
end
