require 'commit_lint/subject_pattern_check'

module Danger
  class DangerCommitLint < Plugin
    class SubjectLengthCheck < CommitCheck # :nodoc:
      MESSAGE = 'Please limit commit subject line to 50 characters.'.freeze

      def self.type
        :subject_length
      end

      def initialize(message)
        @subject = extractSubject(message)
      end

      def fail?
        @subject.length > 50
      end
    end
  end
end
