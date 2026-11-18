require 'erb'
require 'fileutils'
require 'uri'
require_relative 'lib/url-handy'
require_relative 'lib/nomagacha-data'
require_relative 'lib/ng-seed'
require_relative 'lib/nomatora-seed-geminifinder'
require_relative 'lib/true-destiny'
require_relative 'lib/translator'

class StaticBuilder
  def erb(name, opts = {})
    locals = opts[:locals] || {}
    b = binding
    locals.each { |k, v| b.local_variable_set(k.to_sym, v) }
    ERB.new(File.read(File.join(__dir__, 'views', "#{name}.erb"), encoding: 'UTF-8')).result(b)
  end

  def render_page(name, locals = {})
    content = erb(name, locals: locals)
    layout_src = File.read(File.join(__dir__, 'views', 'layout.erb'), encoding: 'UTF-8').gsub('<%= yield %>', '<%= content %>')
    ERB.new(layout_src).result(binding)
  end
end

out_dir = File.join(__dir__, 'public')
FileUtils.mkdir_p(out_dir)
builder = StaticBuilder.new

File.write(File.join(out_dir, 'index.html'), builder.render_page(:index), encoding: 'UTF-8')
File.write(File.join(out_dir, 'finder.html'), builder.render_page(:finder), encoding: 'UTF-8')
File.write(File.join(out_dir, 'howto.html'), builder.render_page(:howto), encoding: 'UTF-8')

credits_text = File.exist?('CREDITS.md') ? File.read('CREDITS.md', encoding: 'UTF-8') : ''
File.write(File.join(out_dir, 'credits.html'), builder.render_page(:credits, { 'creditsText' => credits_text }), encoding: 'UTF-8')

init_params = { 'seed' => '1', 'rolls' => '100', 'nomagachas' => 'nm,ne', 'lastCat' => '' }
data = TrueDestiny.synthesize(init_params)
base = { 'seed' => '1', 'rolls' => '100', 'nomagachas' => 'nm,ne', 'lastCat' => '', 'lang' => 'ja' }

nomatora_html = builder.render_page(:nomatora, {
  'trueDestinyData' => data,
  'baseParams' => base,
  'sixGachas' => NomagachaData::SixGachas,
  'checkedList' => %w[nm ne],
  'langMode' => 'ja'
})
File.write(File.join(out_dir, 'nomatora.html'), nomatora_html, encoding: 'UTF-8')

puts 'Build completed: public/*.html generated.'
