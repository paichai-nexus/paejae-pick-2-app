const adminConsoleHtml = r'''<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="color-scheme" content="light">
  <title>배재Pick 학생식당 운영 콘솔</title>
  <link rel="stylesheet" href="/admin/assets/console.css">
</head>
<body>
  <main class="shell">
    <header class="hero">
      <div>
        <p class="eyebrow">PAICHAI NEXUS · PAEJAE PICK</p>
        <h1>학생식당 운영 콘솔</h1>
        <p class="hero-copy">오늘의 메뉴와 운영 상태를 등록하고 학생 앱에 반영합니다.</p>
      </div>
      <div class="connection" aria-label="연결 상태">
        <span class="connection-dot"></span>
        API 연결 준비
      </div>
    </header>

    <section class="notice" aria-label="보안 안내">
      <strong>관리자 키는 저장되지 않습니다.</strong>
      <span>현재 브라우저 탭에서 요청할 때만 사용하며, 앱 사용자에게 전달하면 안 됩니다.</span>
    </section>

    <div class="workspace">
      <form id="menu-form" class="panel form-panel">
        <div class="panel-heading">
          <div>
            <p class="section-kicker">OPERATIONS</p>
            <h2>메뉴 및 운영 정보</h2>
          </div>
          <button id="load-button" class="button secondary" type="button">기존 정보 불러오기</button>
        </div>

        <div class="field-grid two-columns">
          <label class="field">
            <span>운영 날짜</span>
            <input id="date" name="date" type="date" required>
          </label>
          <label class="field">
            <span>관리자 키</span>
            <input id="admin-key" name="admin-key" type="password" minlength="24" autocomplete="off" data-lpignore="true" spellcheck="false" required placeholder="24자 이상">
          </label>
        </div>

        <div class="field-grid two-columns">
          <label class="field">
            <span>대표 메뉴명</span>
            <input id="menu-name" name="menu-name" maxlength="100" required placeholder="예: 제육덮밥">
          </label>
          <label class="field">
            <span>가격</span>
            <input id="price-label" name="price-label" maxlength="50" placeholder="예: 5,500원">
          </label>
        </div>

        <label class="field">
          <span>구성 메뉴 <small>한 줄에 한 항목</small></span>
          <textarea id="items" name="items" rows="5" maxlength="2200" placeholder="제육볶음&#10;쌀밥&#10;된장국"></textarea>
        </label>

        <div class="field-grid three-columns">
          <label class="field">
            <span>운영 시작</span>
            <input id="opens-at" name="opens-at" type="time" value="11:30" required>
          </label>
          <label class="field">
            <span>운영 종료</span>
            <input id="closes-at" name="closes-at" type="time" value="13:30" required>
          </label>
          <label class="field">
            <span>예상 대기시간</span>
            <div class="number-field">
              <input id="wait-minutes" name="wait-minutes" type="number" min="0" max="120" inputmode="numeric" placeholder="0">
              <span>분</span>
            </div>
          </label>
        </div>

        <fieldset class="field status-field">
          <legend>현재 혼잡도</legend>
          <input id="congestion-status" name="congestion-status" type="hidden" value="normal">
          <div class="status-buttons" role="group" aria-label="혼잡도 선택">
            <button type="button" data-status="preparing">준비 중</button>
            <button type="button" data-status="quiet">여유</button>
            <button type="button" data-status="normal" class="active" aria-pressed="true">보통</button>
            <button type="button" data-status="busy">혼잡</button>
            <button type="button" data-status="closed">운영 종료</button>
          </div>
        </fieldset>

        <label class="field">
          <span>방문 안내</span>
          <input id="recommendation" name="recommendation" maxlength="200" placeholder="예: 지금 방문하면 비교적 여유롭습니다">
        </label>

        <div id="feedback" class="feedback" role="status" aria-live="polite"></div>

        <div class="actions">
          <button id="save-button" class="button primary" type="submit">학생 앱에 반영</button>
        </div>
      </form>

      <aside class="panel preview-panel">
        <div class="panel-heading">
          <div>
            <p class="section-kicker">STUDENT VIEW</p>
            <h2>등록 전 미리보기</h2>
          </div>
          <span id="preview-source" class="source-badge">작성 중</span>
        </div>

        <article class="menu-card">
          <div class="menu-card-top">
            <div>
              <p id="preview-date" class="preview-date">날짜를 선택하세요</p>
              <h3 id="preview-name">대표 메뉴명</h3>
            </div>
            <span id="preview-status" class="status-chip status-normal">보통</span>
          </div>
          <ul id="preview-items" class="preview-items">
            <li>구성 메뉴가 여기에 표시됩니다.</li>
          </ul>
          <dl class="summary-grid">
            <div>
              <dt>운영시간</dt>
              <dd id="preview-hours">11:30–13:30</dd>
            </div>
            <div>
              <dt>가격</dt>
              <dd id="preview-price">가격 확인 필요</dd>
            </div>
            <div>
              <dt>예상 대기</dt>
              <dd id="preview-wait">확인 중</dd>
            </div>
          </dl>
          <p id="preview-recommendation" class="recommendation">방문 안내를 입력하면 학생 화면에 표시됩니다.</p>
        </article>

        <p class="boundary-note">
          이 화면의 혼잡도는 운영자가 입력한 값입니다. 센서 기반 자동 측정값으로 표시하지 않습니다.
        </p>
      </aside>
    </div>
  </main>
  <script src="/admin/assets/console.js" defer></script>
</body>
</html>
''';

const adminConsoleCss = r''':root {
  color: #10213d;
  font-family: -apple-system, BlinkMacSystemFont, "Pretendard", "Segoe UI", sans-serif;
  background: #f3f6fb;
  font-synthesis: none;
}

* { box-sizing: border-box; }

body {
  margin: 0;
  min-width: 320px;
  min-height: 100vh;
  background:
    radial-gradient(circle at 10% 0%, rgba(47, 106, 255, 0.11), transparent 34rem),
    #f3f6fb;
}

button, input, textarea { font: inherit; }
button { cursor: pointer; }

.shell {
  width: min(1180px, calc(100% - 32px));
  margin: 0 auto;
  padding: 48px 0 72px;
}

.hero {
  display: flex;
  justify-content: space-between;
  gap: 24px;
  align-items: flex-end;
  margin-bottom: 24px;
}

.eyebrow, .section-kicker {
  margin: 0 0 8px;
  color: #2f6aff;
  font-size: 12px;
  font-weight: 800;
  letter-spacing: 0.12em;
}

h1, h2, h3, p { overflow-wrap: anywhere; }
h1 { margin: 0; font-size: clamp(30px, 4vw, 48px); letter-spacing: -0.045em; }
h2 { margin: 0; font-size: 21px; letter-spacing: -0.025em; }
h3 { margin: 6px 0 0; font-size: 28px; letter-spacing: -0.035em; }
.hero-copy { margin: 10px 0 0; color: #60708b; }

.connection {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  flex: 0 0 auto;
  padding: 10px 14px;
  border: 1px solid #dbe4f3;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.82);
  color: #425371;
  font-size: 13px;
  font-weight: 700;
}

.connection-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #20b26b;
  box-shadow: 0 0 0 4px rgba(32, 178, 107, 0.12);
}

.notice {
  display: flex;
  gap: 10px;
  margin-bottom: 18px;
  padding: 14px 16px;
  border: 1px solid #cddcff;
  border-radius: 14px;
  background: #edf3ff;
  color: #34517f;
  font-size: 13px;
}

.workspace {
  display: grid;
  grid-template-columns: minmax(0, 1.4fr) minmax(320px, 0.8fr);
  gap: 20px;
  align-items: start;
}

.panel {
  border: 1px solid #e0e7f1;
  border-radius: 24px;
  background: #fff;
  box-shadow: 0 18px 60px rgba(23, 48, 91, 0.08);
}

.form-panel { padding: 28px; }
.preview-panel { position: sticky; top: 20px; padding: 24px; }

.panel-heading {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 24px;
}

.field-grid { display: grid; gap: 16px; }
.two-columns { grid-template-columns: repeat(2, minmax(0, 1fr)); }
.three-columns { grid-template-columns: repeat(3, minmax(0, 1fr)); }

.field {
  display: grid;
  gap: 8px;
  margin-bottom: 18px;
  color: #263a5b;
  font-size: 13px;
  font-weight: 800;
}

.field small { color: #8793a8; font-weight: 600; }

input, textarea {
  width: 100%;
  border: 1px solid #d9e1ed;
  border-radius: 12px;
  outline: 0;
  background: #fbfcfe;
  color: #10213d;
  transition: border-color 150ms ease, box-shadow 150ms ease, background 150ms ease;
}

input { height: 46px; padding: 0 13px; }
textarea { padding: 12px 13px; resize: vertical; line-height: 1.55; }

input:focus, textarea:focus {
  border-color: #2f6aff;
  background: #fff;
  box-shadow: 0 0 0 4px rgba(47, 106, 255, 0.1);
}

.number-field { position: relative; }
.number-field input { padding-right: 38px; }
.number-field span { position: absolute; right: 13px; top: 14px; color: #71809a; }

.status-field { border: 0; padding: 0; }
.status-field legend { margin-bottom: 10px; padding: 0; }
.status-buttons { display: flex; flex-wrap: wrap; gap: 8px; }

.status-buttons button {
  min-height: 40px;
  padding: 0 14px;
  border: 1px solid #d9e1ed;
  border-radius: 12px;
  background: #fff;
  color: #53637d;
  font-size: 13px;
  font-weight: 800;
}

.status-buttons button.active {
  border-color: #2f6aff;
  background: #edf3ff;
  color: #1f5ae5;
}

.button {
  min-height: 44px;
  padding: 0 17px;
  border-radius: 12px;
  font-weight: 800;
}

.button:disabled { cursor: wait; opacity: 0.6; }
.button.primary { border: 1px solid #2f6aff; background: #2f6aff; color: #fff; }
.button.secondary { border: 1px solid #d9e1ed; background: #fff; color: #344664; }
.actions { display: flex; justify-content: flex-end; }

.feedback {
  display: none;
  margin: 0 0 16px;
  padding: 12px 14px;
  border-radius: 12px;
  font-size: 13px;
  font-weight: 700;
}

.feedback.visible { display: block; }
.feedback.success { background: #eaf8f1; color: #157848; }
.feedback.error { background: #fff0f0; color: #bb2d3b; }
.feedback.info { background: #edf3ff; color: #2758b3; }

.source-badge {
  padding: 7px 10px;
  border-radius: 999px;
  background: #eef2f8;
  color: #61708a;
  font-size: 12px;
  font-weight: 800;
}

.menu-card {
  padding: 22px;
  border-radius: 20px;
  background: linear-gradient(145deg, #173c91, #2866e6);
  color: #fff;
  box-shadow: 0 18px 36px rgba(33, 91, 215, 0.24);
}

.menu-card-top { display: flex; justify-content: space-between; gap: 14px; }
.preview-date { margin: 0; color: rgba(255, 255, 255, 0.72); font-size: 13px; font-weight: 700; }

.status-chip {
  align-self: flex-start;
  padding: 7px 10px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.16);
  font-size: 12px;
  font-weight: 900;
  white-space: nowrap;
}

.preview-items { margin: 20px 0; padding-left: 20px; color: rgba(255, 255, 255, 0.86); line-height: 1.65; }
.summary-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; margin: 0; }
.summary-grid div { padding: 12px; border-radius: 13px; background: rgba(255, 255, 255, 0.11); }
.summary-grid dt { color: rgba(255, 255, 255, 0.64); font-size: 11px; font-weight: 700; }
.summary-grid dd { margin: 5px 0 0; font-size: 13px; font-weight: 800; }
.recommendation { margin: 16px 0 0; color: rgba(255, 255, 255, 0.82); font-size: 13px; line-height: 1.5; }
.boundary-note { margin: 16px 2px 0; color: #7a879d; font-size: 12px; line-height: 1.55; }

@media (max-width: 900px) {
  .workspace { grid-template-columns: 1fr; }
  .preview-panel { position: static; }
}

@media (max-width: 640px) {
  .shell { width: min(100% - 20px, 1180px); padding-top: 28px; }
  .hero, .notice, .panel-heading { align-items: flex-start; flex-direction: column; }
  .form-panel, .preview-panel { padding: 19px; border-radius: 20px; }
  .two-columns, .three-columns, .summary-grid { grid-template-columns: 1fr; }
  .panel-heading .button { width: 100%; }
  .actions .button { width: 100%; }
}
''';

const adminConsoleJavaScript = r'''(() => {
  'use strict';

  const form = document.querySelector('#menu-form');
  const dateInput = document.querySelector('#date');
  const adminKeyInput = document.querySelector('#admin-key');
  const menuNameInput = document.querySelector('#menu-name');
  const priceInput = document.querySelector('#price-label');
  const itemsInput = document.querySelector('#items');
  const opensAtInput = document.querySelector('#opens-at');
  const closesAtInput = document.querySelector('#closes-at');
  const waitInput = document.querySelector('#wait-minutes');
  const statusInput = document.querySelector('#congestion-status');
  const recommendationInput = document.querySelector('#recommendation');
  const loadButton = document.querySelector('#load-button');
  const saveButton = document.querySelector('#save-button');
  const feedback = document.querySelector('#feedback');
  const statusButtons = [...document.querySelectorAll('[data-status]')];

  const statusLabels = {
    preparing: '준비 중',
    quiet: '여유',
    normal: '보통',
    busy: '혼잡',
    closed: '운영 종료',
  };

  const localToday = () => {
    const now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
    return now.toISOString().slice(0, 10);
  };

  const selectedItems = () => itemsInput.value
    .split('\n')
    .map((item) => item.trim())
    .filter(Boolean);

  const showFeedback = (message, kind = 'info') => {
    feedback.textContent = message;
    feedback.className = `feedback visible ${kind}`;
  };

  const setBusy = (busy) => {
    loadButton.disabled = busy;
    saveButton.disabled = busy;
  };

  const selectStatus = (status) => {
    const supported = statusLabels[status] ? status : 'normal';
    statusInput.value = supported;
    statusButtons.forEach((button) => {
      const active = button.dataset.status === supported;
      button.classList.toggle('active', active);
      button.setAttribute('aria-pressed', String(active));
    });
    updatePreview();
  };

  const updatePreview = () => {
    document.querySelector('#preview-date').textContent = dateInput.value || '날짜를 선택하세요';
    document.querySelector('#preview-name').textContent = menuNameInput.value.trim() || '대표 메뉴명';
    document.querySelector('#preview-price').textContent = priceInput.value.trim() || '가격 확인 필요';
    document.querySelector('#preview-hours').textContent = `${opensAtInput.value || '--:--'}–${closesAtInput.value || '--:--'}`;
    document.querySelector('#preview-wait').textContent = waitInput.value === '' ? '확인 중' : `${waitInput.value}분`;
    document.querySelector('#preview-recommendation').textContent = recommendationInput.value.trim() || '방문 안내를 입력하면 학생 화면에 표시됩니다.';
    document.querySelector('#preview-status').textContent = statusLabels[statusInput.value] || statusInput.value;

    const list = document.querySelector('#preview-items');
    list.replaceChildren();
    const items = selectedItems();
    (items.length ? items : ['구성 메뉴가 여기에 표시됩니다.']).forEach((item) => {
      const node = document.createElement('li');
      node.textContent = item;
      list.append(node);
    });
  };

  const payload = () => {
    const wait = waitInput.value.trim();
    return {
      menu_name: menuNameInput.value.trim(),
      items: selectedItems(),
      price_label: priceInput.value.trim(),
      operation: {
        opens_at: opensAtInput.value,
        closes_at: closesAtInput.value,
      },
      congestion: {
        status: statusInput.value,
        estimated_wait_minutes: wait === '' ? null : Number(wait),
        recommendation: recommendationInput.value.trim(),
      },
    };
  };

  const applyRecord = (record) => {
    menuNameInput.value = record.menu_name || '';
    priceInput.value = record.price_label || '';
    itemsInput.value = Array.isArray(record.items) ? record.items.join('\n') : '';
    opensAtInput.value = record.operation?.opens_at || '11:30';
    closesAtInput.value = record.operation?.closes_at || '13:30';
    waitInput.value = record.congestion?.estimated_wait_minutes ?? '';
    recommendationInput.value = record.congestion?.recommendation || '';
    selectStatus(record.congestion?.status || 'normal');
    document.querySelector('#preview-source').textContent = '저장된 정보';
    updatePreview();
  };

  const clearMenu = () => {
    menuNameInput.value = '';
    priceInput.value = '';
    itemsInput.value = '';
    opensAtInput.value = '11:30';
    closesAtInput.value = '13:30';
    waitInput.value = '';
    recommendationInput.value = '';
    selectStatus('normal');
    document.querySelector('#preview-source').textContent = '신규 작성';
    updatePreview();
  };

  const readError = async (response) => {
    try {
      const body = await response.json();
      return body.error || `요청 실패 (${response.status})`;
    } catch (_) {
      return `요청 실패 (${response.status})`;
    }
  };

  const loadMenu = async () => {
    if (!dateInput.value) {
      showFeedback('운영 날짜를 먼저 선택하세요.', 'error');
      dateInput.focus();
      return;
    }
    setBusy(true);
    showFeedback('저장된 메뉴를 확인하고 있습니다.');
    try {
      const response = await fetch(`/v1/cafeteria/today?date=${encodeURIComponent(dateInput.value)}`, {
        headers: { accept: 'application/json' },
      });
      if (response.status === 404) {
        clearMenu();
        showFeedback('해당 날짜에 저장된 메뉴가 없습니다. 새로 작성하세요.', 'info');
        return;
      }
      if (!response.ok) throw new Error(await readError(response));
      applyRecord(await response.json());
      showFeedback('저장된 메뉴를 불러왔습니다.', 'success');
    } catch (error) {
      showFeedback(error.message || '메뉴를 불러오지 못했습니다.', 'error');
    } finally {
      setBusy(false);
    }
  };

  const saveMenu = async (event) => {
    event.preventDefault();
    if (!form.reportValidity()) return;
    if (adminKeyInput.value.length < 24) {
      showFeedback('관리자 키는 24자 이상이어야 합니다.', 'error');
      adminKeyInput.focus();
      return;
    }

    setBusy(true);
    showFeedback('메뉴를 저장하고 있습니다.');
    try {
      const response = await fetch(`/v1/admin/cafeteria/${encodeURIComponent(dateInput.value)}`, {
        method: 'PUT',
        headers: {
          'content-type': 'application/json',
          'x-admin-key': adminKeyInput.value,
        },
        body: JSON.stringify(payload()),
      });
      if (!response.ok) throw new Error(await readError(response));
      applyRecord(await response.json());
      showFeedback('저장되었습니다. 학생 앱에서 새로고침하면 반영됩니다.', 'success');
    } catch (error) {
      showFeedback(error.message || '메뉴를 저장하지 못했습니다.', 'error');
    } finally {
      setBusy(false);
    }
  };

  dateInput.value = localToday();
  statusButtons.forEach((button) => button.addEventListener('click', () => selectStatus(button.dataset.status)));
  form.querySelectorAll('input, textarea').forEach((control) => control.addEventListener('input', updatePreview));
  dateInput.addEventListener('change', () => {
    document.querySelector('#preview-source').textContent = '작성 중';
  });
  loadButton.addEventListener('click', loadMenu);
  form.addEventListener('submit', saveMenu);
  updatePreview();
})();
''';
