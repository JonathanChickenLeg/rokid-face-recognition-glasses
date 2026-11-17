<script type="application/json" def>
{
  "navigationBarTitleText": "Auto Recognition",
  "disableScroll": true
}
</script>

<script setup>
export default {
  data: {
    dots: ""
  },

  onShow() {
    this.startAnimation();
  },

  startAnimation() {
    this.stopAnimation();

    this.dotTimer = setInterval(() => {
      let dots = this.data.dots;

      if (dots === "") {
        dots = ".";
      } else if (dots === ".") {
        dots = "..";
      } else if (dots === "..") {
        dots = "...";
      } else {
        dots = "";
      }

      this.setData({
        dots: dots
      });
    }, 500);
  },

  stopAnimation() {
    if (this.dotTimer) {
      clearInterval(this.dotTimer);
      this.dotTimer = null;
    }
  },

  onHide() {
    this.stopAnimation();
  },

  onUnload() {
    this.stopAnimation();
  }
};
</script>

<page>
  <view class="container">
    <view class="content">

      <text class="status">Auto Recognising{{ dots }}</text>

      <view class="border">
        <view class="circle"></view>
        <text class="message">Please look at the camera</text>
        <text class="instruction">Keep your face within the frame</text>
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
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  .status {
    width: 90%;
    font-size: 12px;
    font-weight: bold;
    color: #40ff5e;
    margin-bottom: 5px;
  }

  .border {
    width: 90%;
    height: 270px;
    outline: 1px solid #40ff5e;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  .circle {
    width: 10px;
    height: 10px;
    border: 2px solid #40ff5e;
    border-radius: 50%;
    background-color: transparent;
    margin-bottom: 15px;
  }

  .message {
    font-size: 12px;
    font-weight: bold;
    color: #40ff5e;
    margin-bottom: 8px;
  }

  .instruction {
    font-size: 10px;
    color: rgba(64, 255, 94, 0.72);
  }
</style>