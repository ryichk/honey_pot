namespace :bundle_platform do
  desc 'Update Gemfile.lock platform to x86_64-linux'
  task :update do
    on roles(:app) do
      within release_path do
        # Unfreeze Gemfile.lock
        execute :bundle, 'config unset deployment'

        # Update Gemfile.lock platform
        execute :bundle, 'lock --add-platform x86_64-linux'

        # Refreeze Gemfile.lock
        execute :bundle, "config set deployment 'true'"
      end
    end
  end
end