<template>
  <div class='comments'>
    <CommentList v-if="userinfo.openId" type="user" :comments="comments"></CommentList>
    <div v-if="userinfo.openId">
      <div class="page-title">
        我的图书
      </div>
      <Card v-for="book in books" :key="book.id" :book="book"></Card>
      <div v-if="!books.length">还没有添加图书，快去添加几本吧!</div>
    </div>
  </div>
</template>

<script>
import { get } from '@/utils/util'
import CommentList from '@/components/commentList'
import Card from '@/components/card'
export default {
  data () {
    return {
      comments: [],
      books: [],
      userinfo: {}
    }
  },
  components: {
    CommentList,
    Card
  },
  methods: {
    init () {
      wx.showNavigationBarLoading()
      this.getComments()
      // 获取用户添加的图书
      this.getBooks()
      wx.hideNavigationBarLoading()
    },
    async getComments () {
      const comments = await get('/weapp/commentlist', {
        openId: this.userinfo.openId
      })
      this.comments = comments.list
    },
    async getBooks () {
      const books = await get('/weapp/booklist', {
        openId: this.userinfo.openId
      })
      this.books = books.list
    }
  },
  onPullDownRefresh () {
    this.init()
    wx.stopPullDownRefresh()
  },
  onShow () {
    if (!this.userinfo.openId) {
      let userinfo = wx.getStorageSync('userinfo')
      if (userinfo) {
        this.userinfo = userinfo
        this.init()
      }
    }
  }
}
</script>

<style>

</style>