require 'commit_lint/subject_pattern_check'

module Danger
  class DangerCommitLint < Plugin
    class SubjectCapCheck < CommitCheck # :nodoc:
      def message
        'Please start subject with capital letter.'.freeze
      end

      def self.type
        :subject_cap
      end

      def initialize(message, _config = {})
        @first_character = extract_subject(message).split('').first
      end

      def fail?
        @first_character != @first_character.upcase
      end
    end
  end
end
