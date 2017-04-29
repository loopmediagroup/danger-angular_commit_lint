require 'commit_lint/subject_pattern_check'

module Danger
  class DangerCommitLint < Plugin
    class SubjectLengthCheck < CommitCheck # :nodoc:
      def message
        'Please limit commit subject line to 50 characters.'.freeze
      end

      def self.type
        :subject_length
      end

      def initialize(message, _config = {})
        @subject = extract_subject(message)
      end

      def fail?
        @subject.length > 50
      end
    end
  end
end
