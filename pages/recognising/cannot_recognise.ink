<script type="application/json" def>
{
  "navigationBarTitleText": "Not Recognised",
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

      <text class="status">Unable to Recognise</text>

      <view class="border">
        <view class="circle">
          <text class="cross">!</text>
        </view>

        <text class="message">Person could not be identified</text>
        <text class="name">Unknown Person</text>

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
    width: 45px;
    height: 45px;
    border: 2px solid #40ff5e;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 15px;
  }

  .cross {
    font-size: 25px;
    font-weight: bold;
    color: #40ff5e;
  }

  .message {
    font-size: 12px;
    color: #40ff5e;
    margin-bottom: 8px;
  }

  .name {
    font-size: 20px;
    font-weight: bold;
    color: #40ff5e;
  }
</style>