<template>
  <div class="bookInfo">
    <div class="thumb">
      <img mode="aspectFill" :src="info.image" alt="" class="back">
      <img mode="aspectFit" class="img" :src="info.image" alt="">
      <div class="info">
        <div class="title">
          {{info.title}}
        </div>
        <div class="author">
          {{info.author}}
        </div>
      </div>
    </div>

    <div class="detail">
      <img mode="aspectFit" :src="userinfo.image" alt="" class="avatar">
      {{userinfo.nickName}}
      <div class="right text-primary">
        {{info.rate}}分
        <Rate :value="info.rate"></Rate>
      </div>
      <div class="detail">
        {{info.publisher}}
        <div class="right">
          {{info.price}}
        </div>  
      </div>
    </div>

    <div class="tags">
      <div class="badge" v-for="tag in info.tags" :key="tag">
        {{tag}}
      </div>
      <div class="summary">
        <p v-for="(sum, i) in info.summary" :key="i">{{sum}}</p>
      </div>
    </div>

    <div class="summary">

    </div>
  </div>
</template>

<script>
import Rate from '@/components/rate'
export default {
  components: {
    Rate
  },
  props: {
    info: {
      type: Object,
      default: {}
    }
  },
  computed: {
    userinfo () {
      return this.info.user_info || {}
    }
  }
}
</script>

<style lang="scss" scoped>
  .bookInfo {
    .badge {
      display: inline-block;
      margin: 5px;
      padding: 5px;
      border-radius: 10px;
      border: 1px #fc897c solid;
      color: #fc897c
    }
    .summary {
      padding:0 15px;
      margin-top: 10px;
      p {
        text-indent: 2em;
        font-size: 14px;
      }
    }
    font-size: 14px;
    .right {
      float: right
    }
    .thumb {
      width: 750rpx;
      height: 500rpx;
      overflow: hidden;
      position: relative;
      .back {
        filter: blur(15px);
        width: 100%;
      }
      .img {
        position: absolute;
        width: 100%;
        height: 250rpx;
        left: 0;
        top: 30rpx;
      }
      .info {
        position: absolute;
        width: 100%;
        left: 0;
        top: 330rpx;
        text-align: center;
        color: #fff;
        .title {
          font-size: 20px;
        }
        .author {
          font-size: 14px;
        }
      }
    }
    .detail {
      padding: 5px 10px;
      .avatar {
        width: 20px;
        height: 20px;
        border-radius: 50%;
        vertical-align: middle;
      }
    }
  }
</style>

