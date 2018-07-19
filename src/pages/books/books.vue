<template>
  <div class='books'>
    <TopSwiper :tops="tops"></TopSwiper>
    <Card v-for="book in books" :key="book.id" :book="book"></Card>
    <p class="text-footer" v-show="!more">
      已经加载全部图书啦!
    </p>
  </div>
</template>

<script>
  import { get } from '@/utils/util'
  import Card from '@/components/card'
  import TopSwiper from '@/components/topSwiper'
  export default {
    components: {
      Card, TopSwiper
    },
    data () {
      return {
        books: [],
        pageNo: 0,
        more: true,
        tops: []
      }
    },
    methods: {
      async getList (init) {
        if (init) {
          this.pageNo = 0
          this.more = true
        }
        wx.showNavigationBarLoading()
        const books = await get('/weapp/booklist', {
          pageNo: this.pageNo
        })
        if (books.list.length < 3 && this.pageNo > 0) {
          this.more = false
        }
        if (init) {
          this.books = books.list
          wx.stopPullDownRefresh()
        } else {
          this.books = this.books.concat(books.list)
        }
        // console.log(this.books)
        wx.stopPullDownRefresh()
        wx.hideNavigationBarLoading()
      },
      async getTop () {
        const tops = await get('/weapp/top')
        this.tops = tops.list
      }
    },
    // 微信下拉事件
    onPullDownRefresh () {
      this.getList(true)
      this.getTop()
    },
    // 触底事件
    onReachBottom () {
      if (!this.more) {
        // 已加载 全部
        return false
      }
      this.pageNo = this.pageNo + 1
      this.getList()
    },
    mounted () {
      this.getList(true)
      this.getTop()
    }
  }
</script>

<style>
</style>