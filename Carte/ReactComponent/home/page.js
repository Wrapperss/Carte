import React, { Component } from 'react';
import {
    AppRegistry,
    Platform,
    StyleSheet,
    Text,
    View,
    ScrollView
} from 'react-native';
import CarouselCell from './Cell/CarouselCell'
import SeparateLine from '../Main/SeparateLine'
import TitleView from './View/TitleView'
import MiddleCell from "./Cell/MiddleCell";
import MultiItemCell from './Cell/MultiItemCell'
import Dimensions from 'Dimensions';
let screenWidth = Dimensions.get("window").width;
let screenHeight = Dimensions.get("window").height

export default class HomePage extends Component {
    render() {
        return (
            <View style={styles.container}>
                <ScrollView
                    scrollsToTop={true}
                    showsVerticalScrollIndicator={false}
                    style={styles.mainView}
                    contentContainerStyle={styles.contentContainer}>
                    <CarouselCell
                        content={{
                            headTitle: '今日推荐',
                            subTitle: '全方位的生活指南，每天都有新乐趣',
                        }}
                        ></CarouselCell>
                    <SeparateLine 
                        width={screenWidth-30} 
                        toLeft={15}
                        toTop={5}/>
                    <MiddleCell></MiddleCell>
                    <SeparateLine 
                        width={screenWidth-30} 
                        toLeft={15}
                        toTop={5}/>
                    <MultiItemCell></MultiItemCell>
                    <SeparateLine 
                        width={screenWidth-30} 
                        toLeft={15}
                        toTop={5}/>
                    <MultiItemCell></MultiItemCell>
                    <SeparateLine 
                        width={screenWidth-30} 
                        toLeft={15}
                        toTop={5}/>
                    <CarouselCell
                        content={{
                            headTitle: '三十分钟闪购',
                            subTitle: 'SOS 30min内必达，慢必赔，扫除生活窘迫  ',
                        }}
                        ></CarouselCell>
                    <SeparateLine 
                        width={screenWidth-30} 
                        toLeft={15}
                        toTop={5}/>
                </ScrollView>
            </View>
        );
    }
}


const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#F8F8F8'
    },

    mainView: {
        // height: screenHeight-100,
        paddingVertical: 10,
    },
})

AppRegistry.registerComponent('Carte', () => HomePage)