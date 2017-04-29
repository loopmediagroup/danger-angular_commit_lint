module Danger
  class DangerCommitLint < Plugin
    class CommitCheck # :nodoc:
      def self.fail?(message, config)
        new(message, config).fail?
      end

      def initialize(message, config = {}); end

      def fail?
        raise 'implement in subclass'
      end
    end
  end
end
