<%--
  Created by IntelliJ IDEA.
  User: 拼命三石
  Date: 2019/9/18
  Time: 20:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login</title>
</head>
<script src="/javascripts/jquery/jquery.min.js"></script>
<script src="/javascripts/echarts3/echarts.min.js"></script>
<style>
    body {
        padding: 0px;
        margin: 0px;
    }
    #div-2 {
        width: 400px;
        height: 300px;
        background-color: rgba(245, 245, 245);
        margin-left: 50px;
        margin-top: 50px;
        box-shadow: 0px 0px 5px 5px #aaaaaa;
        overflow: hidden;
    }
    #div-3 {
        width: 300px;
        height: 200px;
        background-color: white;
        margin-left: 50px;
        margin-top: 50px;
        overflow: hidden;
    }
    button {
        width: 150px;
        height: 40px;
        border: none;
        float: left;
        outline: none;
    }
    .button-1 {
        background-color: white;
        border-top: 2px solid red;
        color: blue;
    }
    .div-4 {
        height: 120px;
        margin-left: 30px;
        margin-top: 60px;
    }
    .div-4 button {
        width: 100px;
        height: 40px;
        margin-left: 13px;
        margin-top: 15px;
    }
    .button-3 {
        color: red;
        background-color: white;
    }
    #div-1-2 {
        width: 1000px;
        height: 600px;
        position: absolute;
        right: 50px;
        top: 50px;
    }
</style>
<body>
    <div id="div-1">
        <div id="div-2">
            <div id="div-3">
                <button id="button-1" class="button-1" value="province">岗位地区分布</button>
                <button id="button-2" value="education">岗位学历分布</button>
                <div id="div-4" class="div-4">
                    <button value="map" class="button-3">地图分布</button>
                    <button value="bar">柱状图分布</button>
                    <button value="line">折线图分布</button>
                    <button value="radar">雷达图分布</button>
                </div>
                <div id="div-5" class="div-4">
                    <button value="pie" class="button-3">饼图分布</button>
                    <button value="bar">柱状图分布</button>
                    <button value="line">折线图分布</button>
                    <button value="radar">雷达图分布</button>
                </div>
            </div>
        </div>
        <div id="div-1-2">

        </div>
    </div>
</body>
</html>


<script>

    var chart = echarts.init(document.getElementById('div-1-2'));

    $(function () {

        getChinaMap();

        $("#button-1").click(function () {
            $("#button-2").removeClass("button-1");
            $("#button-1").addClass("button-1");
            $("#div-5").animate({
                width : "hide"
            })
            $("#div-4").animate({
                width : "show"
            })
            for (var i = 0; i < 4; i++) {
                $(".div-4 button").eq(i).removeClass("button-3");
            }
            $(".div-4 button").eq(0).addClass("button-3");
            getChinaMap();
        })

        $("#button-2").click(function () {
            $("#button-1").removeClass("button-1");
            $("#button-2").addClass("button-1");
            $("#div-4").animate({
                width : "hide"
            })
            $("#div-5").animate({
                width : "show"
            })
            for (var i = 4; i < 8; i++) {
                $(".div-4 button").eq(i).removeClass("button-3");
            }
            $(".div-4 button").eq(4).addClass("button-3");
            getPieCharts();
        })

        $(".div-4 button").eq(0).click(function () {
            for (var i = 0; i < 4; i++) {
                $(".div-4 button").eq(i).removeClass("button-3");
            }
            $(".div-4 button").eq(0).addClass("button-3");
            getChinaMap();
        })

        $(".div-4 button").eq(1).click(function () {
            for (var i = 0; i < 4; i++) {
                $(".div-4 button").eq(i).removeClass("button-3");
            }
            $(".div-4 button").eq(1).addClass("button-3");
            getBarCharts("province");
        })

        $(".div-4 button").eq(2).click(function () {
            for (var i = 0; i < 4; i++) {
                $(".div-4 button").eq(i).removeClass("button-3");
            }
            $(".div-4 button").eq(2).addClass("button-3");
            getLineCharts("province");
        })

        $(".div-4 button").eq(3).click(function () {
            for (var i = 0; i < 4; i++) {
                $(".div-4 button").eq(i).removeClass("button-3");
            }
            $(".div-4 button").eq(3).addClass("button-3");
            getRadarCharts("province");
        })

        $(".div-4 button").eq(4).click(function () {
            for (var i = 4; i < 8; i++) {
                $(".div-4 button").eq(i).removeClass("button-3");
            }
            $(".div-4 button").eq(4).addClass("button-3");
            getPieCharts();
        })

        $(".div-4 button").eq(5).click(function () {
            for (var i = 4; i < 8; i++) {
                $(".div-4 button").eq(i).removeClass("button-3");
            }
            $(".div-4 button").eq(5).addClass("button-3");
            getBarCharts("education");
        })

        $(".div-4 button").eq(6).click(function () {
            for (var i = 4; i < 8; i++) {
                $(".div-4 button").eq(i).removeClass("button-3");
            }
            $(".div-4 button").eq(6).addClass("button-3");
            getLineCharts("education");
        })

        $(".div-4 button").eq(7).click(function () {
            for (var i = 4; i < 8; i++) {
                $(".div-4 button").eq(i).removeClass("button-3");
            }
            $(".div-4 button").eq(7).addClass("button-3");
            getRadarCharts("education");
        })

        function getRadarCharts(message) {

            rad.splice(0, rad.length);

            indic.splice(0, indic.length);

            ser.splice(0, ser.length);

            chart.clear();

            $.ajax({
                url : "/getData/" + message,
                type : "post",
                contentType : "application/json",
                success : function (s) {
                    var json = eval("(" + s + ")");
                    var nameList = json.nameList;
                    var valueList = json.valueList;
                    radarCharts(nameList, valueList);
                }
            })
        }

        var rad = [];

        var indic = [];

        var ser = [];

        function getMessage(exList, evList, first, last, number, cent) {

            for (var j = first; j < last; j++) {

                indic.push({
                    text : exList[j],
                    max : Math.max.apply(null, evList.slice(first, last))
                })
            }

            ser.push({
                type: 'radar',
                tooltip: {
                    trigger: 'item'
                },
                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                radarIndex: number,
                data: [
                    {
                        value: evList.slice(first, last),
                        name: "岗位数量"
                    }
                ]
            })

            rad.push({
                indicator: indic.slice(first, last),
                center: cent,
                radius: 80
            })
        }

        function radarCharts(nameList, valueList) {

            var exList = [];

            var evList = [];

            var exList1 = [];

            var evList1= [];

            if (nameList.length > 20) {

                for (var i = 0; i < nameList.length; i++) {

                    if (valueList[i] < 10) {

                        exList.push(nameList[i]);

                        evList.push(valueList[i]);
                    } else {

                        exList1.push(nameList[i]);

                        evList1.push(valueList[i]);
                    }
                }

                if (exList.length > 8) {

                    getMessage(exList, evList, 0, 8, 0, ['35%','30%']);

                    getMessage(exList, evList, 8, 16, 1, ['65%','30%']);

                    getMessage(exList, evList, 16, exList.length, 2, ['35%','70%']);
                }

                indic.splice(0, indic.length);

                getMessage(exList1, evList1, 0, exList1.length, 3, ['65%','70%']);
            } else {

                for (var i = 0; i < nameList.length; i++) {

                    if (valueList[i] < 10) {

                        exList.push(nameList[i]);

                        evList.push(valueList[i]);
                    } else {

                        exList1.push(nameList[i]);

                        evList1.push(valueList[i]);
                    }
                }

                getMessage(exList, evList, 0, exList.length, 0, ['35%','50%']);

                indic.splice(0, indic.length);

                getMessage(exList1, evList1, 0, exList1.length, 1, ['65%','50%']);
            }

            var option = {
                title: {
                    text : '岗位数量多雷达图',
                    x : 'center'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    x : 'right',
                    y : '20',
                    data: ['岗位数量']
                },
                radar: rad,
                series: ser
            };
            chart.setOption(option);
        }

        function getLineCharts(message) {

            chart.clear();

            $.ajax({
                url : "/getData/" + message,
                type : "post",
                contentType : "application/json",
                success : function (s) {
                    var json = eval("(" + s + ")");
                    var nameList = json.nameList;
                    var valueList = json.valueList;
                    lineCharts(valueList, nameList);
                }
            })
        }

        function lineCharts(valueList, nameList) {
            option = {
                title: {
                    text: '折线图岗位分布',
                    subtext: '来自招聘网站',
                    x : 'center'
                },
                grid:{
                    x:50,
                    y:50,
                    x2:50,
                    y2:50,
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data:['岗位数量'],
                    x : 'right',
                    y : '20'
                },
                xAxis:  {
                    type: 'category',
                    boundaryGap: false,
                    data: nameList,
                    axisLabel: {
                        show: true,  //这里的show用于设置是否显示x轴下的字体 默认为true
                        interval: 0,
                        textStyle : {
                            fontSize : 10
                        }
                    }
                },
                yAxis: {
                    type : 'value'
                },
                series: [
                    {
                        name :'岗位数量',
                        type : 'line',
                        data : valueList,
                        label: {
                            normal: {
                                show: true,
                                position: 'top'
                            }
                        }
                    }
                ]
            };
            chart.setOption(option);
        }

        function getBarCharts(message) {

            chart.clear();

            $.ajax({
                url : "/getData/" + message,
                type : "post",
                contentType : "application/json",
                success : function (s) {
                    var json = eval("(" + s + ")");
                    var nameList = json.nameList;
                    var valueList = json.valueList;
                    barCharts(valueList, nameList);
                }
            })
        }

        function barCharts(valueList, nameList) {
            option = {
                title: {
                    text: '柱状图岗位分布',
                    subtext: '来自招聘网站',
                    x: 'center'
                },
                grid:{
                    x:50,
                    y:50,
                    x2:50,
                    y2:50,
                },
                xAxis: {
                    type: 'category',
                    data: nameList,
                    axisLabel: {
                        show: true,  //这里的show用于设置是否显示x轴下的字体 默认为true
                        interval: 0,
                        textStyle : {
                            fontSize : 10
                        }
                    }
                },
                yAxis: {
                    type: 'value'
                },
                series: [{
                    data: valueList,
                    type: 'bar',
                    stack: '总量',
                    label: {
                        normal: {
                            show: true,
                            position: 'top'
                        }
                    }
                }]
            };
            chart.setOption(option);
        }

        function getPieCharts() {

            chart.clear();

            var all = [];

            $.ajax({
                url: "/getData/education",
                type: "post",
                contentType: "application/json",
                success: function (s) {
                    var json = eval("(" + s + ")");
                    var nameList = json.nameList;
                    var valueList = json.valueList;
                    for (var i = 0; i < nameList.length; i++) {
                        all.push({
                            name: nameList[i],
                            value: valueList[i]
                        })
                    }
                    pieCharts(all, nameList);
                }
            })

        }

        function pieCharts(all, nameList) {
            var option = {
                title: {
                    text: '岗位学历分布',
                    subtext: '来自招聘网站',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    type: 'scroll',
                    orient: 'vertical',
                    right: 10,
                    top: 20,
                    bottom: 20,
                    data: nameList
                },
                series: [
                    {
                        name: '学历',
                        type: 'pie',
                        radius : [60, 160],
                        center : ['50%', '50%'],
                        roseType : 'area',
                        zoom : 1.5,
                        data: all,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            chart.setOption(option);
        }

        function getChinaMap() {

            chart.clear();

            var all = [];

            $.ajax({
                url : "/getData/province",
                type : "post",
                contentType : "application/json",
                success : function (s) {
                    var json = eval("(" + s + ")");
                    var nameList = json.nameList;
                    var valueList = json.valueList;
                    for (var i = 0; i < nameList.length; i++) {
                        all.push({
                            name : nameList[i],
                            value : valueList[i]
                        })
                    }
                    chinaMap(all);
                }
            })
        }

        function chinaMap(all) {
            $.get("/javascripts/echarts3/china.json", function(data) {//这里是json转js，如果是js文件就不需要这一步
                echarts.registerMap("中国", data);//设置地图
                var option = {
                    tooltip: {
                        trigger: 'item'
                    },
                    legend: {
                        data: ['岗位数量']
                    },
                    toolbox: { //toolbox
                        show: true,
                        orient: 'vertical', //布局方式，默认为水平布局，可选为：'horizontal' | 'vertical'
                        x: 'right',
                        y: 'center',
                        feature: {
                            mark: {
                                show: true
                            },
                            dataView: {
                                show: true,
                                readOnly: false
                            },
                            restore: {
                                show: true
                            },
                            saveAsImage: {
                                show: true
                            }
                        }
                    },
                    series: [
                        {
                            name: '岗位数量',
                            map: '中国',
                            type: 'map',
                            roam: false,//是否开启鼠标缩放和平移漫游
                            top: '10%',//组件距离容器的距离
                            zoom: 1.2,
                            selectedMode: 'single',
                            label: {
                                normal: {
                                    show: true,//显示省份标签
                                    textStyle: {color: "black"}//省份标签字体颜色
                                },
                                emphasis: {//对应的鼠标悬浮效果
                                    show: true,
                                    textStyle: {color: "#323232"}
                                }
                            },
                            itemStyle: {
                                normal: {
                                    borderWidth: .5,//区域边框宽度
                                    borderColor: '#0550c3',//区域边框颜色
                                    areaColor: "white",//区域颜色
                                },
                                emphasis: {
                                    borderWidth: .5,
                                    borderColor: '#4b0082',
                                    areaColor: "#ece39e",
                                }
                            },
                            data : all
                        }]
                }
                chart.setOption(option);
            })
        }
    })
</script>
