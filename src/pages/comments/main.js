import Vue from 'vue'
import Comments from './comments'

const app = new Vue(Comments)
app.$mount()

export default {
  config: {
    navigationBarTitleText: '评论列表',
    enablePullDownRefresh: true
  }
}
