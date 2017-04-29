def extractSubject(message)
  return message[:subject].split(': ')[1] ||= message[:subject]
end

module Danger
  class DangerCommitLint < Plugin
    class SubjectPatternCheck < CommitCheck # :nodoc:
      MESSAGE = "Please follow the commit format `<type>(<scope>): <subject>`. `<scope>` must be blank, brackets are optional, or at least 4 characters long".freeze

      def self.type
        :subject_cap
      end
      
      def initialize(message)
        @subject = message[:subject]
      end

      def fail?
        defaultCommitTypes = [
          'fix', 'feat', 'docs', 'style', 'refactor', 'test', 'chore'
          ]
        regex_string = "^(#{defaultCommitTypes.join '|'})(\\([a-zA-Z0-9-]{4,}\\)|\\(\\)|): .+$"
        (@subject =~ Regexp.new(regex_string)) == nil
      end
    end
  end
end
