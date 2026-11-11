<script def>
{
  "navigationBarTitleText": "Face Recognition"
}
</script>

<script setup>
import wx from 'wx';
import { getCount, getSettings } from '../../utils/db.js';

var ALIAS_DEDUPE_MS = 1200;
var PHANTOM_WINDOW_MS = 800;

export default {
  data: {
    menuItems: [
      { id: 'overlay', name: 'Recognition', subtitle: 'Live overlay', route: '/pages/overlay/overlay' },
      { id: 'people', name: 'People', subtitle: 'Manage known individuals', route: '/pages/enrollment/enrollment' },
      { id: 'settings', name: 'Settings', subtitle: 'Toggles and sync', route: '/pages/settings/settings' }
    ],
    selectedIdx: 0,
    peopleCount: 0,
    recognitionOn: true,
    privacyOn: false,
    boundaryMsg: ''
  },

  onLoad() {
    this._armedAt = Date.now();
    this._lastAliasTime = 0;
    this._lastAliasDelta = 0;
    this._boundaryTimer = null;
  },

  onShow() {
    this._armedAt = Date.now();
    var count = getCount();
    var s = getSettings();
    this.setData({
      peopleCount: count,
      recognitionOn: s.recognitionEnabled,
      privacyOn: s.privacyMode
    });
  },

  onUnload() {
    if (this._boundaryTimer) {
      clearTimeout(this._boundaryTimer);
      this._boundaryTimer = null;
    }
  },

  showBoundary(msg) {
    this.setData({ boundaryMsg: msg });
    if (this._boundaryTimer) clearTimeout(this._boundaryTimer);
    this._boundaryTimer = setTimeout(() => {
      this.setData({ boundaryMsg: '' });
      this._boundaryTimer = null;
    }, 1500);
  },

  navigateToSelected() {
    var item = this.data.menuItems[this.data.selectedIdx];
    if (!item || !item.route) return;
    wx.navigateTo({ url: item.route });
  },

  onKeyDown(event) {
    if (!event) return;
  },

  onKeyUp(event) {
    if (!event || !event.code) return;
    if (Date.now() - this._armedAt < PHANTOM_WINDOW_MS) return;

    var code = event.code;

    if (code === 'GlobalHook') return;

    if (code === 'ArrowUp' || code === 'ArrowLeft') {
      var delta = -1;
      var now = Date.now();
      if (this._lastAliasDelta === delta && now - this._lastAliasTime < ALIAS_DEDUPE_MS) return;
      this._lastAliasDelta = delta;
      this._lastAliasTime = now;

      var cur = this.data.selectedIdx;
      if (cur <= 0) {
        this.showBoundary('First item');
        return;
      }
      this.setData({ selectedIdx: cur - 1 });
      return;
    }

    if (code === 'ArrowDown' || code === 'ArrowRight') {
      var delta2 = 1;
      var now2 = Date.now();
      if (this._lastAliasDelta === delta2 && now2 - this._lastAliasTime < ALIAS_DEDUPE_MS) return;
      this._lastAliasDelta = delta2;
      this._lastAliasTime = now2;

      var cur2 = this.data.selectedIdx;
      if (cur2 >= this.data.menuItems.length - 1) {
        this.showBoundary('Last item');
        return;
      }
      this.setData({ selectedIdx: cur2 + 1 });
      return;
    }

    if (code === 'Enter') {
      event.preventDefault();
      this.navigateToSelected();
      return;
    }

    if (code === 'Backspace') {
      return;
    }
  },

  onTapItem(e) {
    var idx = e.currentTarget.dataset.index;
    if (typeof idx === 'undefined') return;
    this.setData({ selectedIdx: idx }, () => {
      this.navigateToSelected();
    });
  }
};
</script>

<page>
  <view class="page-root">
    <view class="topbar">
      <text class="topbar-title">Face Recognition</text>
      <text class="topbar-count">{{peopleCount}} known</text>
    </view>

    <view class="menu-list">
      <view class="menu-row" ink:for="{{menuItems}}" ink:key="id" bindtap="onTapItem" data-index="{{index}}">
        <view class="menu-marker">
          <view class="menu-dot" ink:if="{{selectedIdx === index}}"></view>
        </view>
        <view class="menu-text">
          <text class="menu-name">{{item.name}}</text>
          <text class="menu-subtitle">{{item.subtitle}}</text>
        </view>
        <view class="menu-status" ink:if="{{item.id === 'overlay'}}">
          <text class="status-on" ink:if="{{recognitionOn && !privacyOn}}">ON</text>
          <text class="status-off" ink:if="{{!recognitionOn || privacyOn}}">OFF</text>
        </view>
      </view>
    </view>

    <view class="boundary-bar" ink:if="{{boundaryMsg}}">
      <text class="boundary-text">{{boundaryMsg}}</text>
    </view>

    <view class="hint-bar">
      <text class="hint-text">Swipe to navigate · Tap to confirm · Double-tap to exit</text>
    </view>
  </view>
</page>

<style>
.page-root {
  width: 480px;
  height: 352px;
  display: flex;
  flex-direction: column;
  padding: 12px 16px;
  box-sizing: border-box;
  background-color: #000000;
}

.topbar {
  flex: 0 0 30px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
}

.topbar-title {
  font-size: 16px;
  font-weight: 500;
  color: rgba(64,255,94,0.72);
  line-height: 30px;
}

.topbar-count {
  font-size: 11px;
  color: rgba(64,255,94,0.48);
  line-height: 30px;
}

.menu-list {
  flex: 1 1 auto;
  min-height: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.menu-row {
  display: flex;
  flex-direction: row;
  align-items: center;
  height: 44px;
  padding: 0 8px;
  border: 1px solid transparent;
  border-radius: 4px;
  margin-bottom: 4px;
}

.menu-marker {
  width: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.menu-dot {
  width: 6px;
  height: 6px;
  border-radius: 9999px;
  background-color: #40ff5e;
}

.menu-text {
  flex: 1 1 auto;
  display: flex;
  flex-direction: column;
  margin-left: 8px;
}

.menu-name {
  font-size: 14px;
  color: rgba(64,255,94,0.72);
  line-height: 20px;
}

.menu-subtitle {
  font-size: 10px;
  color: rgba(64,255,94,0.48);
  line-height: 14px;
}

.menu-status {
  width: 28px;
  display: flex;
  align-items: center;
  justify-content: flex-end;
}

.status-on {
  font-size: 10px;
  color: rgba(64,255,94,0.72);
}

.status-off {
  font-size: 10px;
  color: rgba(64,255,94,0.24);
}

.boundary-bar {
  flex: 0 0 18px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.boundary-text {
  font-size: 10px;
  color: rgba(64,255,94,0.48);
}

.hint-bar {
  flex: 0 0 18px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.hint-text {
  font-size: 10px;
  color: rgba(64,255,94,0.24);
}
</style>
