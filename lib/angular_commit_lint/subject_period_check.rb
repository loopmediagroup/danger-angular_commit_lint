require 'angular_commit_lint/subject_pattern_check'

module Danger
  class DangerAngularCommitLint < Plugin
    class SubjectPeriodCheck < CommitCheck # :nodoc:
      def message
        'Please remove period from end of commit subject line.'.freeze
      end

      def self.type
        :subject_period
      end

      def initialize(message, _config = {})
        @subject = extract_subject(message)
      end

      def fail?
        @subject.split('').last == '.'
      end
    end
  end
end
