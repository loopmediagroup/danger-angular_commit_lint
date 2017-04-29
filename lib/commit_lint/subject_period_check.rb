require 'commit_lint/subject_pattern_check'

module Danger
  class DangerCommitLint < Plugin
    class SubjectPeriodCheck < CommitCheck # :nodoc:
      def message() 'Please remove period from end of commit subject line.'.freeze end

      def self.type
        :subject_period
      end

      def initialize(message, config = {})
        @subject = extractSubject(message)
      end

      def fail?
        @subject.split('').last == '.'
      end
    end
  end
end
