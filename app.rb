require 'sinatra'
require 'json'
require 'uri'
require_relative 'lib/url-handy'
require_relative 'lib/nomagacha-data'
require_relative 'lib/ng-seed'
require_relative 'lib/nomatora-seed-geminifinder'
require_relative 'lib/true-destiny'
require_relative 'lib/translator'

set :port, 8080
set :bind, '0.0.0.0'
set :public_folder, File.join(__dir__, 'public')

get('/') { erb :index }

get '/nomatora' do
  checked = URI.decode_www_form(request.query_string).select { |k, _| k == 'nomagachas_selected' }.map(&:last)
  checked = params['nomagachas'].split(',') if checked.empty? && params['nomagachas'] && !params['nomagachas'].empty?
  checked = %w[nm ne] if checked.empty? && !params.key?('seed')

  params['nomagachas'] = checked.join(',')
  lang = params['lang'].to_s.empty? ? 'ja' : params['lang']
  data = TrueDestiny.synthesize(params)

  base = {
    'seed' => data['seed'].to_s,
    'rolls' => data['numRolls'].to_s,
    'nomagachas' => params['nomagachas'],
    'lastCat' => data['lastCat'],
    'lang' => lang
  }

  erb :nomatora, locals: {
    'trueDestinyData' => data,
    'baseParams' => base,
    'sixGachas' => NomagachaData::SixGachas,
    'checkedList' => checked,
    'langMode' => lang
  }
end

get('/finder') { erb :finder }
get('/howto') { erb :howto }
get('/credits') { erb :credits, locals: { 'creditsText' => File.exist?('CREDITS.md') ? File.read('CREDITS.md', encoding: 'UTF-8') : '' } }
