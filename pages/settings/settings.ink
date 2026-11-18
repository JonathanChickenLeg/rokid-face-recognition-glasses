<script type="application/json" def>
{
  "navigationBarTitleText": "Settings",
  "disableScroll": true
}
</script>

<script setup>
export default {
  data: {
    autoRecognition: false,
    showDetails: true,

    autoText: "OFF",
    detailsText: "ON",

    selectedIndex: 0,

    autoRowClass: "setting-row selected",
    detailsRowClass: "setting-row",
    backRowClass: "back-container"
  },

  onLoad() {
    const settings = wx.getStorageSync("nameAssistantSettings");

    if (settings) {
      this.setData({
        autoRecognition: settings.autoRecognition === true,
        showDetails: settings.showDetails !== false,

        autoText: settings.autoRecognition ? "ON" : "OFF",
        detailsText: settings.showDetails ? "ON" : "OFF"
      });
    }
  },

  onKeyUp(event) {
    console.log("Temple event:", event.code);

    switch (event.code) {
      case "ArrowDown":
        event.preventDefault();
        this.selectNext();
        break;

      case "ArrowUp":
        event.preventDefault();
        this.selectPrevious();
        break;

      case "Enter":
        event.preventDefault();
        this.activateSelected();
        break;

      case "GlobalHook":
        // Ignore general temple touch events
        break;

      default:
        break;
    }
  },

  selectNext() {
    const next = (this.data.selectedIndex + 1) % 3;
    this.selectSetting(next);
  },

  selectPrevious() {
    const previous =
      (this.data.selectedIndex + 2) % 3;
    this.selectSetting(previous);
  },

  selectSetting(index) {
    this.setData({
      selectedIndex: index,

      autoRowClass: index === 0
        ? "setting-row selected"
        : "setting-row",

      detailsRowClass: index === 1
        ? "setting-row selected"
        : "setting-row",

      backRowClass: index === 2
        ? "back-container selected"
        : "back-container"
    });
  },

  activateSelected() {
    if (this.data.selectedIndex === 0) {
      this.toggleAuto();
    } else if (this.data.selectedIndex === 1) {
      this.toggleDetails();
    } else {
      this.goBack();
    }
  },

  saveSettings() {
    wx.setStorageSync("nameAssistantSettings", {
      autoRecognition: this.data.autoRecognition,
      showDetails: this.data.showDetails
    });
  },

  toggleAuto() {
    const value = !this.data.autoRecognition;

    this.setData({
      autoRecognition: value,
      autoText: value ? "ON" : "OFF"
    });

    this.saveSettings();
  },

  toggleDetails() {
    const value = !this.data.showDetails;

    this.setData({
      showDetails: value,
      detailsText: value ? "ON" : "OFF"
    });

    this.saveSettings();
  },

  tapAuto() {
    this.selectSetting(0);
    this.toggleAuto();
  },

  tapDetails() {
    this.selectSetting(1);
    this.toggleDetails();
  },

  goBack() {
    wx.navigateBack({ delta: 1 });
  }
};
</script>

<page>
  <view class="container">
    <view class="content">

      <!-- Header -->
      <view class="title-row">
        <text class="title">Settings</text>
        <text class="text">Swipe left or right to navigate</text>
      </view>
      <view class="divider"></view>

      <!-- Auto Recognition -->
      <view class="{{autoRowClass}}">
        <view class="setting-info">
          <text class="setting-title">Auto Recognition</text>
          <text class="description">Start automatically</text>
        </view>

        <view class="toggle-btn">
          <text class="toggle-text">{{autoText}}</text>
        </view>
      </view>

      <view class="divider"></view>

      <!-- Show Details -->
      <view class="{{detailsRowClass}}">
        <view class="setting-info">
          <text class="setting-title">Show Details</text>
          <text class="description">Display person information</text>
        </view>

        <view class="toggle-btn">
          <text class="toggle-text">{{detailsText}}</text>
        </view>
      </view>

      <view class="divider"></view>

      <!-- Back Button -->
      <view class="{{backRowClass}}">
        <text class="back-text">Back</text>
      </view>

    </view>
  </view>
</page>

<style>
  page {
    background-color: #000000;
  }

  .container {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .content {
    width: 90%;
    display: flex;
    flex-direction: column;
  }

  .title-row {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
  }

  .title {
    font-size: 20px;
    margin-bottom: 10px;
  }
  
  .text {
    font-size: 10px;
    font-weight: bold;
  }

  .divider {
    width: 100%;
    height: 1px;
    background-color: #245c2e;
    margin-top: 6px;
    margin-bottom: 6px;
  }

  .setting-row {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;

    padding: 6px;
    border: 1px solid transparent;
    border-radius: 6px;
  }

  .selected {
    border: 1px solid #40ff5e;
    background-color: #102816;
  }

  .setting-info {
    display: flex;
    flex-direction: column;
  }

  .setting-title {
    color: #40ff5e;
    font-size: 13px;
    font-weight: bold;
  }

  .description {
    color: #8da993;
    font-size: 10px;
    margin-top: 3px;
  }

  .toggle-btn {
    border: 1px solid #40ff5e;
    border-radius: 5px;
    padding: 5px 10px;
    min-width: 30px;
    align-items: center;
  }

  .toggle-text {
    color: #40ff5e;
    font-size: 12px;
    font-weight: bold;
  }

  .back-container {
    margin-top: 12px;
    border: 1px solid #245c2e;
    border-radius: 6px;
    padding: 8px;
    align-items: center;
  }

  .back-container.selected {
    border: 1px solid #40ff5e;
    background-color: #102816;
  }

  .back-text {
    color: #40ff5e;
    font-size: 12px;
    font-weight: bold;
  }
</style>
