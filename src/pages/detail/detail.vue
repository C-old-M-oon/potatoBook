<template>
  <div class="detail">
    <BookInfo :info="info"></BookInfo>
    <CommentList :comments="comments"></CommentList>
    <div class="comment" v-if="showAdd">
      <textarea v-model="comment"
                class="textarea"
                :maxlength="100"
                placeholder="请输入图书短评"></textarea>
      <div class="location">
        地理位置:
        <switch color="#ea5a49" :checked="location" @change="getGeo"></switch>
        <span class="text-primary">{{location}}</span>
      </div>
      <div class="phone">
        手机型号:
        <switch color="#ea5a49" :checked="phone" @change="getPhone"></switch>
        <span class="text-primary">{{phone}}</span>
      </div>
      <button class="themeBtn" @click="addComment">
        发表评论
      </button>
    </div>
    <div v-else class="text-footer">
      未登陆或者已经评论过了
    </div>
    <button class="themeBtn" open-type="share">
      转发给好友
    </button>
  </div>
</template>

<script>
import { get, post, showModal, showSuccess } from '@/utils/util'
import BookInfo from '@/components/bookInfo'
import CommentList from '@/components/commentList'
export default {
  components: {
    BookInfo,
    CommentList
  },
  data () {
    return {
      comments: [],
      userinfo: {},
      bookid: '',
      info: {},
      comment: '',
      location: '',
      phone: ''
    }
  },
  computed: {
    showAdd () {
      // 未登陆
      if (!this.userinfo.openId) {
        return false
      }
      if (this.comments.filter(v => v.openId === this.userinfo.openId).length) {
        return false
      }
      return true
    }
  },
  methods: {
    async getDetail () {
      const info = await get('/weapp/bookdetail', {
        id: this.bookid
      })
      this.info = info
      wx.setNavigationBarTitle({
        title: info.title
      })
      // console.log(info)
    },
    // 获取评论
    async getComments () {
      const comments = await get('/weapp/commentlist', {
        bookid: this.bookid
      })
      this.comments = comments.list || []
    },
    getGeo (e) {
      // 百度地图token:yzAHyG2aIUAQIaRq6W2edK2dfrFVlBhi
      // 百度地图请求地址：http://api.map.baidu.com/geocoder/v2/?callback=renderReverse&location=35.658651,139.745415&output=json&pois=1&ak=您的ak //GET请求
      const ak = 'yzAHyG2aIUAQIaRq6W2edK2dfrFVlBhi'
      const url = 'http://api.map.baidu.com/geocoder/v2/'
      if (e.target.value) {
        wx.getLocation({
          success: geo => {
            wx.request({
              url,
              data: {
                ak,
                location: `${geo.latitude},${geo.longitude}`,
                output: 'json'
              },
              success: res => {
                // console.log(res)
                if (res.data.status === 0) {
                  this.location = res.data.result.addressComponent.province + res.data.result.addressComponent.city
                } else {
                  this.location = '未知地点'
                }
              }
            })
          }
        })
      } else {
        this.location = ''
      }
    },
    getPhone (e) {
      if (e.target.value) {
        const phoneInfo = wx.getSystemInfoSync()
        this.phone = phoneInfo.model
        // console.log(phoneInfo)
      } else {
        this.phone = ''
      }
    },
    async addComment () {
      if (!this.comment) {
        return
      }
      // 评价内容 手机型号 地理位置 图书ID 用户openId
      const data = {
        openId: this.userinfo.openId,
        bookid: this.bookid,
        comment: this.comment,
        phone: this.phone,
        location: this.location
      }
      try {
        await post('/weapp/addcomment', data)
        showSuccess('评论成功!')
        this.comment = ''
        this.getComments()
      } catch (err) {
        showModal('评论失败：', err)
      }
      // console.log(data)
    }
  },
  mounted () {
    // 获取页面参数
    this.bookid = this.$root.$mp.query.id
    this.getDetail()
    this.getComments()
    // 获取用户信息
    const userinfo = wx.getStorageSync('userinfo')
    if (userinfo) {
      this.userinfo = userinfo
    }
  },
  onShareAppMessage: function (res) {
    return true
  }
}
</script>

<style lang="scss">
  .comment {
    margin-top: 10px;
    .textarea {
      width: 730rpx;
      height: 200rpx;
      background: #eee;
      padding: 10rpx;
    }
    .location {
      margin-top: 10px;
      padding: 5px 10px;
    }
    .phone {
      margin-top: 10px;
      padding: 5px 10px;
    }
  }
</style>
