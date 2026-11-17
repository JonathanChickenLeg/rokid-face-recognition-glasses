<script type="application/json" def>
{
  "navigationBarTitleText": "Idle",
  "disableScroll": true
}
</script>

<script setup>
export default {
  startRecognition() {}
};
</script>

<page>
  <view class="container">
    <view class="content">
      <text class="idle">Idle</text>

      <view class="border">
        <view class="circle"></view>
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
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  .idle {
    width: 90%;
    font-size: 12px;
    font-weight: bold;
    text-align: left;
    color: #40ff5e;
    margin-bottom: 5px;
  }

  .border {
    width: 90%;
    height: 270px;
    outline: 1px solid #40ff5e;
    align-items: center;
    justify-content: center;
  }

  .circle {
    width: 10px;
    height: 10px;
    border: 2px solid #40ff5e;
    border-radius: 50%;
    background-color: transparent;
  }
</style>