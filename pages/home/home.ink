<script def>
{
  "navigationBarTitleText": "Home"
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

      <text class="title">RecognizeMe</text>

      <!-- Glasses Icon -->
      <text class="icon">⚯</text>

      <!-- App Title -->
      <text class="title">Name Assistant</text>

      <!-- Start Button -->
      <view class="start-btn" bindtap="startRecognition">
        <text class="btn-text">Start Recognition</text>
      </view>

      <text class="text">Click to Start</text>

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
    height: 130px;
    border-radius: 12px;

    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  .icon {
    font-size: 22px;
    color: rgba(64, 255, 94, 0.72);
    margin-bottom: 8px;
  }

  .title {
    font-size: 15px;
    font-weight: bold;
    color: rgba(64, 255, 94, 0.72);
    margin-bottom: 10px;
  }
  
  .text {
    font-size: 10px;
    color: rgba(64, 255, 94, 0.72);
    margin-bottom: 10px;
  }

  .start-btn {
    border-radius: 10px;
    padding: 10px 15px;
    outline: 1px solid rgba(64, 255, 94, 0.72);
    margin-bottom: 10px;
  }

  .btn-text {
    font-size: 15px;
    font-weight: bold;
    color: rgba(64, 255, 94, 0.72);
  }
</style>
