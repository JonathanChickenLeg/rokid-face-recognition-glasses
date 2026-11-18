<script type="application/json" def>
  {
    "navigationBarTitleText": "Idle",
    "disableScroll": true
  }
</script>

<script setup>
  export default {
    onKeyUp(event) {
      if (event.code === "GlobalHook") {
        event.preventDefault();
        this.startCapturing();
      }
    },

    startCapturing() {
      if (this.navigating) return;

      this.navigating = true;

      wx.redirectTo({
        url: "/pages/capturing/capturing",

        fail: (error) => {
          this.navigating = false;
          console.error("Navigation failed:", error);
        }
      });
    },
  };
</script>

<page>
  <view class="container">
    <view class="content">
      <text class="capturing">Idle</text>
      <view class="border">
        <view class="circle"></view>
      </view>
    </view>
  </view>
</page>

<style>
  .content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  .capturing {
    width: 90%;
    font-size: 12px;
    font-weight: bold;
    text-align: left;
    margin-bottom: 5px;
  }

  .border {
    width: 90%;
    height: 270px;
    outline: 1px solid 	#40ff5e;
    align-items: center;
    justify-content: center
  }

  .circle {
    width: 10px;
    height: 10px;
    border: 2px solid #40ff5e;
    border-radius: 50%;
    background-color: transparent;
  }
</style>