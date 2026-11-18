(() => {
  const isStatic = location.pathname.endsWith('.html') || location.protocol === 'file:';
  if (!isStatic) return;

  const GACHAS = [
    {
      name: 'Normal+', short: 'n+', rsum: Array.of(10000),
      pools: [{ units: ['Nuko','Tank','Battle','Kimo','Usi','Tori','Fish','Tokage','Kyojin','Cyojin','Kougeki','Charge','Kouritu','Osaihu','Tairyoku','Kenkyuu','Kaikei','Benkyou','Tousotu'], reroll: true }]
    },
    {
      name: 'Fukubiki', short: 'fu', rsum: new Array(0, 7400, 9500, 10000),
      pools: [
        { units: [], reroll: false },
        { units: ['TiKyojin','TiToka','TiFish','TiTori','TiUsi','TiKimo','TiBattle','TiTank','TiNuko','SPD','SPD','SPD','CPU','CPU','10K','10K','10K','30K','30K','30K'], reroll: true },
        { units: ['BON','OKM','SNP'], reroll: false },
        { units: ['TRD'], reroll: false }
      ]
    },
    {
      name: 'FukubikiG', short: 'fg', rsum: new Array(0, 5100, 8600, 10000),
      pools: [
        { units: [], reroll: false },
        { units: ['btA','btA','btA','G100K','G100K','G100K'], reroll: true },
        { units: ['btB','btB','btB','500K'], reroll: false },
        { units: ['btC','btC','btC','1M'], reroll: false }
      ]
    },
    {
      name: 'Nekome', short: 'ne', rsum: new Array(500, 7400, 9400, 9900, 10000),
      pools: [
        { units: ['5K'], reroll: false },
        { units: ['10K','30K','ExMe','ReaMe'], reroll: true },
        { units: ['100K','GekiMe'], reroll: false },
        { units: ['CyoMe'], reroll: false },
        { units: ['GemiMe'], reroll: false }
      ]
    },
    {
      name: 'Matatabi', short: 'ma', rsum: new Array(400, 2400, 9400, 10000),
      pools: [
        { units: ['5K'], reroll: false },
        { units: ['SPD','CPU','10K','30K','50K','Muratane','Akatane','Aotane','Midotane','Keytane'], reroll: true },
        { units: ['BON','OKM','SNP','100K','200K','Muramt','Akamt','Aomt','Midomt','Keymt'], reroll: false },
        { units: ['TRD','500K','Nijimt'], reroll: false }
      ]
    },
    {
      name: 'Normal', short: 'nm', rsum: Array.of(10000),
      pools: [{ units: ['Nuko','Tank','Battle','Kimo','Usi','Tori','Fish','Tokage','Kyojin','Kougeki','Charge','Kouritu','Osaihu','Tairyoku','Kenkyuu','Kaikei','Benkyou','Tousotu'], reroll: true }]
    }
  ];

  const DICT = {
    GemiMe: ['【闇】','闇','Y','grp-d'], btC: ['BC','Ｃ','C','grp-c'], TRD: ['TR','T','T','grp-t'],
    Kougeki: ['攻撃','攻','K','grp-b'], Charge: ['ﾁｬｰｼﾞ','充','K','grp-b'], Kouritu: ['効率','効','K','grp-b'],
    Osaihu: ['財布','財','K','grp-b'], Tairyoku: ['体力','体','K','grp-b'], Kenkyuu: ['研究','研','K','grp-b'],
    Kaikei: ['会計','会','K','grp-b'], Benkyou: ['勉強','勉','K','grp-b'], Tousotu: ['統率','統','K','grp-b'],
    Nuko: ['ﾈｺ','猫','2','grp-n'], Tank: ['ﾀﾝｸ','壁','2','grp-n'], Battle: ['ﾊﾞﾄﾙ','斧','2','grp-n'],
    Kimo: ['ｷﾓ','奇','2','grp-n'], Usi: ['ｳｼ','牛','2','grp-n'], Tori: ['ﾄﾘ','鳥','2','grp-n'],
    Fish: ['ﾌｨｯｼｭ','魚','2','grp-n'], Tokage: ['ﾄｶｹﾞ','竜','2','grp-n'], Kyojin: ['巨神','巨','2','grp-n'], Cyojin: ['超人','超','2','grp-n'],
    TiNuko: ['ﾁﾋﾞﾈｺ','猫','1','grp-l'], TiTank: ['ﾁﾋﾞﾀﾝ','壁','1','grp-l'], TiBattle: ['ﾁﾋﾞﾊﾞﾄ','斧','1','grp-l'],
    TiKimo: ['ﾁﾋﾞｷﾓ','奇','1','grp-l'], TiUsi: ['ﾁﾋﾞｳｼ','牛','1','grp-l'], TiTori: ['ﾁﾋﾞﾄﾘ','鳥','1','grp-l'],
    TiFish: ['ﾁﾋﾞﾌｨ','魚','1','grp-l'], TiToka: ['ﾁﾋﾞﾄｶ','竜','1','grp-l'], TiKyojin: ['ﾁﾋﾞｷｮ','巨','1','grp-l'],
    '5K': ['0.5万','.5','X','grp-z'], '10K': ['1万','①','X','grp-z'], '30K': ['3万','③','X','grp-z'],
    '50K': ['5万','⑤','X','grp-z'], '100K': ['10万','⑩','X','grp-z'], G100K: ['10万','⑩','X','grp-z'],
    '200K': ['20万','⑳','X','grp-z'], '500K': ['50万','㊿','X','grp-z'], '1M': ['100万','百','X','grp-z'],
    SPD: ['SPD','速','U','grp-z'], CPU: ['NPU','動','P','grp-z'], BON: ['BON','凡','ﾎﾞ','grp-z'],
    OKM: ['OKM','瓶','J','grp-z'], SNP: ['SNP','砂','ﾊﾟ','grp-z'], btA: ['BA','Ａ','A','grp-z'], btB: ['BB','Ｂ','B','grp-z'],
    Muratane: ['紫ﾀﾈ','ﾑﾗ','ﾀ','grp-z'], Akatane: ['赤ﾀﾈ','ｱｶ','ﾀ','grp-z'], Aotane: ['青ﾀﾈ','ｱｵ','ﾀ','grp-z'],
    Midotane: ['緑ﾀﾈ','ﾐﾄﾞ','ﾀ','grp-z'], Keytane: ['黄ﾀﾈ','ｷｲ','ﾀ','grp-z'],
    Muramt: ['[紫]','紫','ﾑ','grp-z'], Akamt: ['[赤]','赤','ｶ','grp-z'], Aomt: ['[青]','青','ｵ','grp-z'],
    Midomt: ['[緑]','緑','ﾐ','grp-z'], Keymt: ['[黄]','黄','ｷ','grp-z'], Nijimt: ['[虹]','虹','ﾆ','grp-z'],
    ExMe: ['【EX】','Ｅ','E','grp-z'], ReaMe: ['【ﾚｱ】','ﾚ','ﾚ','grp-z'], GekiMe: ['【激】','ｹﾞ','ｹﾞ','grp-z'], CyoMe: ['【超】','ﾁ','ﾁ','grp-z']
  };

  const HEAD = {
    Normal: ['ﾉｰﾏﾙ','並'], 'Normal+': ['ﾉｰﾏﾙ+','＋'], Matatabi: ['ﾏﾀﾀﾋﾞ','叉'],
    Nekome: ['猫目','眼'], Fukubiki: ['福引','福'], FukubikiG: ['福引G','Ｇ']
  };

  const step = (s) => { s ^= s << 13; s >>>= 0; s ^= s >>> 17; s ^= s << 15; return s >>>= 0; };
  const tierOf = (s, rsum) => { const m = s % 10000; return rsum.findIndex((v) => m < v); };
  const pickFrom = (s, u, rem = []) => {
    if (!rem.length) { const m = s % u.length; return [m, u[m]]; }
    const m = s % (u.length - rem.length);
    return [m, u[m + rem.filter((i) => i <= m).length]];
  };

  const forecast = (s, depth, g) => Array.from({ length: depth }, () => {
    const tSeed = step(s);
    const tier = tierOf(tSeed, g.rsum);
    const p = g.pools[tier];
    s = step(tSeed);
    const [idx, actor] = pickFrom(s, p.units);
    let alt = null;
    if (p.reroll) {
      let aSeed = s, aActor = actor;
      const seen = [idx], lim = p.units.length - 1;
      for (let k = 0; k < lim && aActor === actor; k++) {
        aSeed = step(aSeed);
        const [nIdx, nextActor] = pickFrom(aSeed, p.units, seen);
        aActor = nextActor;
        seen.push(nIdx);
      }
      alt = { id: aActor, seed: aSeed };
    }
    return { tierSeed: tSeed, primary: { id: actor, seed: s }, fallback: alt, warp: null };
  });

  const fmtLabel = (k, mode) => {
    const e = DICT[k];
    if (!e) return k;
    if (mode === 'en') return k;
    if (mode === 'short2') return e.at(1) + e.at(2);
    return e.at(0);
  };
  const fmtHead = (k, mode) => {
    const e = HEAD[k];
    if (!e) return k;
    if (mode === 'en') return k;
    if (mode === 'short2') return e.at(1);
    return e.at(0);
  };
  const grpCls = (k) => (DICT[k] ? DICT[k].at(3) : 'grp-none');
  const qs = (obj) => new URLSearchParams(obj).toString();

  const qp = new URLSearchParams(location.search);
  let origin = parseInt(qp.get('seed'), 10);
  if (!(origin >= 1 && origin <= 0xFFFFFFFF)) origin = 1;

  let depth = parseInt(qp.get('rolls'), 10);
  if (!(depth >= 1 && depth <= 1000)) depth = 100;

  let codes = qp.getAll('nomagachas_selected');
  if (!codes.length && qp.get('nomagachas')) codes = qp.get('nomagachas').split(',').filter(Boolean);
  if (!codes.length && !qp.has('seed')) codes = ['nm', 'ne'];

  const priorActor = qp.get('lastCat') || '';
  const lang = qp.get('lang') || 'ja';

  const form = document.getElementById('nomatora-form');
  if (form) {
    form.querySelector('input[name="seed"]').value = origin;
    form.querySelector('select[name="rolls"]').value = String(depth);
    form.querySelector('select[name="lang"]').value = lang;
    form.querySelector('input[name="lastCat"]').value = priorActor;
    form.querySelectorAll('input[name="nomagachas_selected"]').forEach((cb) => {
      cb.checked = codes.includes(cb.value);
    });
  }

  const projections = GACHAS.filter((g) => codes.includes(g.short)).map((g) => ({
    title: g.name,
    code: g.short,
    alpha: forecast(origin, depth + 10, g),
    beta: forecast(step(origin), depth + 10, g)
  }));

  projections.forEach((proj) => {
    const atlas = new Map();
    proj.alpha.forEach((node, i) => atlas.set(node.tierSeed, [node, `${i + 1}A`]));
    proj.beta.forEach((node, i) => atlas.set(node.tierSeed, [node, `${i + 1}B`]));

    const triggers = [];
    [[priorActor, proj.alpha], ['', proj.beta]].forEach(([p0, lane]) => {
      let prev = p0;
      lane.forEach((node) => {
        if (node.fallback && node.primary.id === prev) triggers.push(node.tierSeed);
        prev = node.primary.id;
      });
    });

    triggers.forEach((tSeed) => {
      const hit = atlas.get(tSeed);
      if (!hit) return;
      let [cursor] = hit;
      let guard = cursor.primary.id;
      while (cursor.primary.id === guard && cursor.fallback) {
        guard = cursor.fallback.id;
        const nxtHit = atlas.get(step(cursor.fallback.seed));
        if (!nxtHit) break;
        const [target, coord] = nxtHit;
        cursor.warp = { active: true, dest: coord };
        cursor = target;
      }
    });
  });

  const base = { seed: String(origin), rolls: String(depth), nomagachas: codes.join(','), lastCat: priorActor, lang };

  const renderTrack = (label, key) => {
    let h = `<div class="dy-maint"><div class="dy-row"><div class="dy-head dy-num-col dynum-top">${label}</div>`;
    projections.forEach((g) => { h += `<div class="dy-head dy-data-col dynum-top">${fmtHead(g.title, lang)}</div>`; });
    h += '</div>';

    for (let r = 0; r < depth; r++) {
      h += `<div class="dy-row"><div class="dycell dy-num-col"><div class="dycell-top dynum-top">${r + 1}</div><div class="dycell-btm dynum-btm">&nbsp;</div></div>`;
      projections.forEach((g) => {
        const node = g[key][r];
        const u1 = node.primary;
        const g1 = grpCls(u1.id);
        const l1 = fmtLabel(u1.id, lang);
        const href1 = `?${qs({ ...base, seed: String(step(u1.seed)), lastCat: u1.id })}`;
        const warped = node.warp && node.warp.active && node.fallback;

        h += '<div class="dycell dy-data-col">';
        if (warped) {
          const u2 = node.fallback;
          const g2 = grpCls(u2.id);
          const l2 = fmtLabel(u2.id, lang);
          const href2 = `?${qs({ ...base, seed: String(step(u2.seed)), lastCat: u2.id })}`;
          const dest = node.warp.dest || '';
          h += `<div class="dycell-top ${g1}"><a href="${href1}" class="dy-link">${l1}</a></div>`;
          h += `<div class="dycell-btm ${g2}">`;
          h += label === 'B'
            ? `<span class="dy-dest">&lt;-${dest}</span><a href="${href2}" class="dy-link">${l2}</a>`
            : `<a href="${href2}" class="dy-link">${l2}</a><span class="dy-dest">-&gt;${dest}</span>`;
          h += '</div>';
        } else {
          h += `<div class="dycell-top ${g1}">&nbsp;</div>`;
          h += `<div class="dycell-btm ${g1}"><a href="${href1}" class="dy-link">${l1}</a></div>`;
        }
        h += '</div>';
      });
      h += '</div>';
    }
    return `${h}</div>`;
  };

  const container = document.querySelector('.ally-gem');
  if (container) {
    container.className = `ally-gem mode-${lang}`;
    const org = container.querySelector('.org-gem');
    if (org) org.innerHTML = renderTrack('A', 'alpha') + renderTrack('B', 'beta');
  }
})();
