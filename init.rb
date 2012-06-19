require 'redmine'
require 'dispatcher'

require_dependency 'meta_hook'

RAILS_DEFAULT_LOGGER.info 'Starting Meta Tags Plugin for Redmine'

Dispatcher.to_prepare :meta_plugin do
    unless ActionView::Base.included_modules.include?(MetaHelper)
        ActionView::Base.send(:include, MetaHelper)
    end
end

Redmine::Plugin.register :meta_plugin do
    name 'Meta tags'
    author 'Andriy Lesyuk'
    author_url 'http://www.andriylesyuk.com'
    description 'Adds an ability to specify meta description and keywords.'
    url 'http://projects.andriylesyuk.com/projects/redmine-meta'
    version '0.1.0'
end
