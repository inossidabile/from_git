require 'rubygems/command_manager'

class Gem::Commands::FromGitCommand < Gem::Command

  def description
    "Allows you to install gem from git repository"
  end

  def initialize
    super 'from_git', description

    add_option('-b', '--branch LOCATION', arguments) do |branch|
      options[:branch] = branch
    end

  end

  def arguments
    "PATH         https://github.com/user/repo.git"
    "BRANCH       Git branch to use"
  end

  def usage
    "#{program_name} [LOCATION] -b [BRANCH]"
  end

  def execute
    require 'fileutils'
    require 'tempfile'
    require 'colored'

    destination = Dir.mktmpdir

    begin
      error "No repository specified" unless options[:args].length > 0

      run "git clone #{options[:args][0]} #{destination}", "Error cloning repository"

      Dir.chdir destination do
        if options[:branch]
          run "git checkout #{options[:branch]}", "Error checkouting branch"
        end

        run "gem build *.gemspec", "Error building gem"
        run "gem install *.gem",    "Error installing gem"
      end

      puts "Done".green
      exit 0
    ensure
      FileUtils.rm_rf destination
    end
  end

  private

  def run(command, error_message)
    system(command) || error(error_message)
  end

  def error(string)
    puts string.red
    exit 1
  end
end

Gem::CommandManager.instance.register_command :from_git