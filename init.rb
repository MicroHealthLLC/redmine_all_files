require 'redmine_all_files'
require 'redmine/i18n'

Redmine::Plugin.register :redmine_all_files do
  name 'Redmine All Files plugin'
  author 'Dmitry Kovalenok'
  description 'Plugin for Redmine to view all attachments related to current project'
  version '0.0.4'
  url 'https://github.com/twinslash/redmine_all_files'
  author_url 'https://github.com/twinslash'

  project_module :all_files do
    permission :view_all_files, { :project_attachments => [:index] }
  end
  menu :project_menu, :all_files,
       { :controller => 'project_attachments', :action => 'index' },
       :caption => Proc.new { |project| I18n.t('project_module_all_files') }, :after => :files, :param => :project_id
  menu :top_menu, :all_files, { :controller => 'project_attachments', :action => 'index' },:if => Proc.new {
    User.current.allowed_to_globally?(:view_all_files, {})
  }, :caption => Proc.new { |project| I18n.t('project_module_all_files')  }, :after => :projects
end

