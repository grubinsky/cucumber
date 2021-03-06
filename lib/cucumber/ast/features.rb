module Cucumber
  module Ast
    class Features
      include Enumerable

      attr_reader :duration

      def initialize
        @features = []
      end

      def each(&proc)
        @features.each(&proc)
      end

      def add_feature(feature)
        feature.features = self
        @features << feature
      end

      def accept(visitor)
        return if $cucumber_interrupted
        start = Time.now
        self.each do |feature|
          visitor.visit_feature(feature)
        end
        @duration = Time.now - start
      end
    end
  end
end