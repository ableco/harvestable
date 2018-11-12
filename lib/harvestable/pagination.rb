module Her
  module Model
    class Relation
      def per_page(per_page)
        where(per_page: per_page)
      end

      def page(page)
        where(page: page)
      end
    end
  end
end
