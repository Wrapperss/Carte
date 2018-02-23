import React, { Component } from 'react';
import {
    AppRegistry,
    Platform,
    StyleSheet,
    Text,
    View,
    ScrollView
} from 'react-native';
import ImageCell from "./imageCell"
import SeparateLine from '../main/separateLine'
import Dimensions from 'Dimensions';
let screenWidth = Dimensions.get("window").width;

export default class CarouselCell extends Component {
    render() {
        return (
            <View style={styles.container}>
                <View style={styles.top}>
                    <View style={{ flex: 8 }}>
                        <Text style={styles.headTitle}>今日推荐</Text>
                        <Text style={styles.subTitle}>全方位的生活指南，每天都有新乐趣</Text>
                    </View>
                    <Text style={ styles.indicator } >1/6</Text>
                </View>
                

                <View style={styles.bottom}>
                    <ScrollView 
                    style={{
                        height: 255,
                    }}
                    horizontal={true}
                    pagingEnabled={true}
                    showsHorizontalScrollIndicator={false} >
                            <ImageCell></ImageCell>
                            <ImageCell></ImageCell>
                            <ImageCell></ImageCell>
                    </ScrollView>
                    <SeparateLine 
                        width={screenWidth-30} 
                        toLeft={15}/>
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        height: 320,
    },

    top: {
        height: 60,
        flexDirection: 'row',
        alignItems: 'center',
    },     

    headTitle: {
        marginLeft: 15,
        fontSize: 20,
        fontWeight: 'bold',
    },

    subTitle: {
        marginTop: 5,
        marginLeft: 15,
        color: '#9B9B9B',
    },

    indicator: {
        fontSize: 15,
        marginRight: 20,
    },

    bottom: {
        height: 260,
    },

    page: {

    },
})