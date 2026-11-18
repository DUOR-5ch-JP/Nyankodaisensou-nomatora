require_relative 'ng-seed'

module TrueDestiny
  HORIZON = 10

  def self.synthesize(params)
    origin = UrlQuery.get(params, 'seed').to_i
    origin = 1 unless (1..0xFFFFFFFF).cover?(origin)

    depth = UrlQuery.get(params, 'rolls').to_i
    depth = 100 unless (1..1000).cover?(depth)

    raw_codes = UrlQuery.get(params, 'nomagachas')
    codes = raw_codes.empty? && !params.key?('seed') ? %w[nm ne] : raw_codes.split(',')

    prior_actor = UrlQuery.get(params, 'lastCat')
    projections = NgSeed.project_all(origin, depth + HORIZON, codes)

    projections.each do |proj|
      atlas = {}
      proj['alpha_lane'].each_with_index { |node, i| atlas[node['tier_seed']] = [node, "#{i + 1}A"] }
      proj['beta_lane'].each_with_index { |node, i| atlas[node['tier_seed']] = [node, "#{i + 1}B"] }

      triggers = []
      [[prior_actor, proj['alpha_lane']], ['', proj['beta_lane']]].each do |prev, lane|
        lane.each do |node|
          triggers << node['tier_seed'] if node['fallback'] && node['primary']['id'] == prev
          prev = node['primary']['id']
        end
      end

      triggers.each do |t_seed|
        cursor, = atlas[t_seed]
        next unless cursor

        guard = cursor['primary']['id']
        while cursor['primary']['id'] == guard && cursor['fallback']
          guard = cursor['fallback']['id']
          target, coord = atlas[NgSeed.step(cursor['fallback']['seed'])]
          break unless target

          cursor['warp'] = { 'active' => true, 'dest' => coord }
          cursor = target
        end
      end
    end

    {
      'seed' => origin,
      'numRolls' => depth,
      'selectedNomagachas' => codes,
      'lastCat' => prior_actor,
      'alpha' => projections.map { |p| { 'title' => p['title'], 'code' => p['code'], 'nodes' => p['alpha_lane'].first(depth) } },
      'beta' => projections.map { |p| { 'title' => p['title'], 'code' => p['code'], 'nodes' => p['beta_lane'].first(depth) } }
    }
  end
end
