require 'commit_lint/subject_pattern_check'

module Danger
  class DangerCommitLint < Plugin
    class SubjectWordsCheck < CommitCheck # :nodoc:
      def message() 'Please use more than one word.'.freeze end

      def self.type
        :subject_words
      end

      def initialize(message, config = {})
        @subject = extractSubject(message)
      end

      def fail?
        @subject.split.count < 2
      end
    end
  end
end
