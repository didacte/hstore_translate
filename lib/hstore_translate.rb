require 'active_record'
require 'active_record/connection_adapters/postgresql_adapter'
require 'hstore_translate/translates'

module HstoreTranslate
  def self.native_hstore?
    @native_hstore ||= ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::NATIVE_DATABASE_TYPES.key?(:hstore)
  end
end

require 'activerecord-postgres-hstore' unless HstoreTranslate::native_hstore?

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.extend(HstoreTranslate::Translates)
end
