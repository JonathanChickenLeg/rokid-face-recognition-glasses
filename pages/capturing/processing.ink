<script type="application/json" def>
  {
    "navigationBarTitleText": "Processing",
    "disableScroll": true
  }
</script>

<script setup>
  export default {
    startRecognition() {},

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
          dots = ""
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
      <text class="processing">Processing{{ dots }}</text>
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

  .processing {
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