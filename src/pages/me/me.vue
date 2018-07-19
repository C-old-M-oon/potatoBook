<template>
  <div class='me'>
    <div class="container">
      <div class="userinfo" @click="doLogin">
        <img :src="userinfo.avatarUrl" alt="">
        <p v-show="logined">{{userinfo.nickName}}</p>
        <button open-type="getUserInfo" lang="zh_CN" @getuserinfo="doLogin" v-show="!logined">点击登陆</button>
      </div>

      <YearProgress></YearProgress>

      <button class="themeBtn" v-show="logined" @click='scanBook'>添加图书</button>

    </div>
  </div>
</template>

<script>
import config from '@/utils/config'
import qcloud from 'wafer2-client-sdk'
import {showSuccess, post, showModal} from '@/utils/util'
import YearProgress from '@/components/yearProgress'
export default {
  components: {
    YearProgress
  },
  data () {
    return {
      logined: false,
      userinfo: {
        avatarUrl: '../../../static/img/other.png',
        nickName: '点击登陆'
      }
    }
  },
  methods: {
    async addBook (isbn) {
      // console.log(isbn)
      const res = await post('/weapp/addbook', {
        isbn,
        openId: this.userinfo.openId
      })
      showModal('添加成功', `${res.title}添加成功`)
    },
    scanBook () {
      wx.scanCode({
        success: res => {
          if (res.result) {
            this.addBook(res.result)
          }
        }
      })
    },
    doLogin () {
      qcloud.setLoginUrl(config.loginUrl)
      const user = wx.getStorageSync('userinfo')
      if (!user) {
        // 首次登录
        qcloud.login({
          success: res => {
            wx.setStorageSync('userinfo', res)
            this.logined = true
            showSuccess('登录成功')
            this.userinfo = res
          },
          fail: err => {
            console.error(err)
            console.log('登录错误', err.message)
            this.logined = false
          }
        })
      } else {
        // showSuccess('登录成功')
        this.userinfo = wx.getStorageSync('userinfo')
        this.logined = true
      }
    }
  },
  onShow () {
    let userinfo = wx.getStorageSync('userinfo')
    if (userinfo) {
      this.userinfo = userinfo
      this.logined = true
      // console.log(userinfo)
    }
  }
}
</script>

<style lang="scss">
  .me {
    .container {
      padding: 30px;
      .userinfo {
        text-align: center;
        img {
          width: 200rpx;
          height: 200rpx;
          border-radius: 200rpx;
        }
        p {
          margin: 40rpx 0;
        }
      }
    }
  }
</style>