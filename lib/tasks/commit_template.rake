    namespace :template do
      desc "Sets git commit template in the scope of this project"
      task :commit do
        print "[34msetting git template...[0m"
        sh "git config commit.template './.github/commit.template'"
      end
    end
