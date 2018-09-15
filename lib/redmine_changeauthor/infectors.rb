module RedmineChangeauthor::Infectors
  Dir[File.join(File.dirname(__FILE__), 'infectors', '*.rb')].each do |file|
    require_dependency file;
    infected_name = File.basename(file, '.rb').classify
    _module = const_get(infected_name)
    _class = Kernel.const_get(infected_name)
    _class.send(:prepend, _module) unless _class.included_modules.include? _module
  end
end
