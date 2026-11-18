module UrlQuery
  Defaults = {
    'seed' => '1',
    'nomagachas' => 'nm,ne',
    'rolls' => '100',
    'lastCat' => ''
  }

  def self.get(params, key)
    val = params[key] || params[key.to_sym]
    val.nil? || val.to_s.empty? ? Defaults[key] : val.to_s
  end
end