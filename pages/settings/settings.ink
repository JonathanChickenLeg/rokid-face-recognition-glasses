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
    detailsText: "ON"
  },

  onLoad() {
    const saved = wx.getStorageSync("nameAssistantSettings");

    if (saved) {
      this.setData({
        autoRecognition: saved.autoRecognition === true,
        showDetails: saved.showDetails !== false,

        autoText: saved.autoRecognition ? "ON" : "OFF",
        detailsText: saved.showDetails !== false ? "ON" : "OFF"
      });
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
      <view class="setting-row" bindtap="toggleAuto">
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
      <view class="setting-row" bindtap="toggleDetails">
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
      <view class="back-container">
        <text class="back-text">Double Tap to Exit</text>
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
    padding-top: 6px;
    padding-bottom: 6px;
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
    border: 1px solid #40ff5e;
    border-radius: 6px;
    padding: 8px;
    align-items: center;
  }

  .back-text {
    color: #40ff5e;
    font-size: 12px;
    font-weight: bold;
  }
</style>
