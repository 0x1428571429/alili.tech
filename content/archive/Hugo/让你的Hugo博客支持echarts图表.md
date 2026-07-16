---
title: 让你的Hugo博客支持echarts图表
categories: [Blogging]
tags: [Hugo]
slug: r5ibcpo557h
keywords: [Hugo,博客,Shortcodes,echarts]
date: 2018-11-19 16:14:25
---

在之前hexo构建的博客里,有使用到图表,但是现在迁移到hugo之后,就没有相关的插件支持了.

所以自己动手丰衣足食.

在hugo中有支持一种特性叫做 `Shortcodes`.简单的来说就是一个可以传参的小模板.


# 创建Shortcodes
创建 `./layouts/Shortcodes/echarts.html`文件

```html
<div id="echarts{{ .Get `height` }}" style="width: 100%;height: {{.Get `height`}}px;margin: 0 auto"></div>
<script src="https://cdn.bootcss.com/echarts/3.8.0/echarts.common.min.js"></script>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('echarts{{ .Get `height` }}'));
    // 指定图表的配置项和数据
    var option = JSON.parse({{ .Inner }})
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
```

# 使用
在 Shortcodes 插入echarts的配置数据,这样你就可以再页面中看到一个完整的图表了


{{< raw  >}}
<pre>
<code class="language-json hljs">
<span class="hljs-string">"{{"</span> &lt; echarts height=<span class="hljs-string">"400"</span> &gt; <span class="hljs-string">"}}"</span>
<br>
{<span class="hljs-attr">"textStyle"</span>:{<span class="hljs-attr">"color"</span>:<span class="hljs-string">"#fff"</span>},<span class="hljs-attr">"title"</span>:{<span class="hljs-attr">"text"</span>:<span class="hljs-string">"2018年11月国内浏览器数据统计"</span>,<span class="hljs-attr">"subtext"</span>:<span class="hljs-string">"浏览器数据分析"</span>,<span class="hljs-attr">"x"</span>:<span class="hljs-string">"center"</span>,<span class="hljs-attr">"textStyle"</span>:{<span class="hljs-attr">"color"</span>:<span class="hljs-string">"#fff"</span>}},<span class="hljs-attr">"tooltip"</span>:{<span class="hljs-attr">"trigger"</span>:<span class="hljs-string">"item"</span>,<span class="hljs-attr">"formatter"</span>:<span class="hljs-string">"{a} &lt;br/&gt;{b} : {c} ({d}%)"</span>},<span class="hljs-attr">"legend"</span>:{<span class="hljs-attr">"type"</span>:<span class="hljs-string">"scroll"</span>,<span class="hljs-attr">"orient"</span>:<span class="hljs-string">"vertical"</span>,<span class="hljs-attr">"right"</span>:<span class="hljs-number">10</span>,<span class="hljs-attr">"top"</span>:<span class="hljs-number">120</span>,<span class="hljs-attr">"bottom"</span>:<span class="hljs-number">20</span>,<span class="hljs-attr">"data"</span>:[<span class="hljs-string">"Chrome"</span>,<span class="hljs-string">"IE 9.0"</span>,<span class="hljs-string">"IE 11.0"</span>,<span class="hljs-string">"QQ"</span>,<span class="hljs-string">"IE 8.0"</span>,<span class="hljs-string">"2345"</span>,<span class="hljs-string">"搜狗高速"</span>,<span class="hljs-string">"Firefox"</span>,<span class="hljs-string">"Safari"</span>,<span class="hljs-string">"其他"</span>],<span class="hljs-attr">"textStyle"</span>:{<span class="hljs-attr">"color"</span>:<span class="hljs-string">"#fff"</span>}},<span class="hljs-attr">"series"</span>:[{<span class="hljs-attr">"name"</span>:<span class="hljs-string">"浏览器用户比例"</span>,<span class="hljs-attr">"type"</span>:<span class="hljs-string">"pie"</span>,<span class="hljs-attr">"radius"</span>:<span class="hljs-string">"55%"</span>,<span class="hljs-attr">"center"</span>:[<span class="hljs-string">"50%"</span>,<span class="hljs-string">"60%"</span>],<span class="hljs-attr">"data"</span>:[{<span class="hljs-attr">"name"</span>:<span class="hljs-string">"Chrome"</span>,<span class="hljs-attr">"value"</span>:<span class="hljs-number">46.88</span>},{<span class="hljs-attr">"name"</span>:<span class="hljs-string">"IE 9.0"</span>,<span class="hljs-attr">"value"</span>:<span class="hljs-number">7.4</span>},{<span class="hljs-attr">"name"</span>:<span class="hljs-string">"IE 11.0"</span>,<span class="hljs-attr">"value"</span>:<span class="hljs-number">6.21</span>},{<span class="hljs-attr">"name"</span>:<span class="hljs-string">"QQ"</span>,<span class="hljs-attr">"value"</span>:<span class="hljs-number">5.75</span>},{<span class="hljs-attr">"name"</span>:<span class="hljs-string">"IE 8.0"</span>,<span class="hljs-attr">"value"</span>:<span class="hljs-number">5.74</span>},{<span class="hljs-attr">"name"</span>:<span class="hljs-string">"2345"</span>,<span class="hljs-attr">"value"</span>:<span class="hljs-number">5.68</span>},{<span class="hljs-attr">"name"</span>:<span class="hljs-string">"搜狗高速"</span>,<span class="hljs-attr">"value"</span>:<span class="hljs-number">4.74</span>},{<span class="hljs-attr">"name"</span>:<span class="hljs-string">"Firefox"</span>,<span class="hljs-attr">"value"</span>:<span class="hljs-number">2.54</span>},{<span class="hljs-attr">"name"</span>:<span class="hljs-string">"Safari"</span>,<span class="hljs-attr">"value"</span>:<span class="hljs-number">2.48</span>},{<span class="hljs-attr">"name"</span>:<span class="hljs-string">"其他"</span>,<span class="hljs-attr">"value"</span>:<span class="hljs-number">12.59</span>}],<span class="hljs-attr">"itemStyle"</span>:{<span class="hljs-attr">"emphasis"</span>:{<span class="hljs-attr">"shadowBlur"</span>:<span class="hljs-number">10</span>,<span class="hljs-attr">"shadowOffsetX"</span>:<span class="hljs-number">0</span>,<span class="hljs-attr">"shadowColor"</span>:<span class="hljs-string">"rgba(0, 0, 0, 0.5)"</span>}}}]}
<br>
<span class="hljs-string">"{{"</span> &lt; /echarts &gt; <span class="hljs-string">"}}"</span>
</code>
</pre>
{{< /raw >}}


# 效果

{{< echarts height="400" >}}
    {"textStyle":{"color":"#fff"},"title":{"text":"2018年11月国内浏览器数据统计","subtext":"浏览器数据分析","x":"center","textStyle":{"color":"#fff"}},"tooltip":{"trigger":"item","formatter":"{a} <br/>{b} : {c} ({d}%)"},"legend":{"type":"scroll","orient":"vertical","right":10,"top":120,"bottom":20,"data":["Chrome","IE 9.0","IE 11.0","QQ","IE 8.0","2345","搜狗高速","Firefox","Safari","其他"],"textStyle":{"color":"#fff"}},"series":[{"name":"浏览器用户比例","type":"pie","radius":"55%","center":["50%","60%"],"data":[{"name":"Chrome","value":46.88},{"name":"IE 9.0","value":7.4},{"name":"IE 11.0","value":6.21},{"name":"QQ","value":5.75},{"name":"IE 8.0","value":5.74},{"name":"2345","value":5.68},{"name":"搜狗高速","value":4.74},{"name":"Firefox","value":2.54},{"name":"Safari","value":2.48},{"name":"其他","value":12.59}],"itemStyle":{"emphasis":{"shadowBlur":10,"shadowOffsetX":0,"shadowColor":"rgba(0, 0, 0, 0.5)"}}}]}
{{< /echarts >}}