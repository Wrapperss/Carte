import React, { Component } from 'react';
import {
    AppRegistry,
    Platform,
    StyleSheet,
    Text,
    View,
    ScrollView
} from 'react-native';

export default class CarouselCell extends Component {
    render() {
        return (
            <View style={styles.container}>
                <View sytle={styles.top}>
                    {/* <View style={{ backgroundColor: 'red' }}>
                        <Text style={styles.headTitle}>今日推荐</Text>
                        <Text style={styles.subTitle}>全方位的生活指南，每天都有新乐趣</Text>
                    </View>
                    <View style={{ backgroundColor: 'green' }}>
                        <Text>1/6</Text>
                    </View> */}
                </View>
                

                <View style={styles.bottom}></View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        height: 320,
        borderColor: 'red',
        borderWidth: 1,
        flexDirection: 'column',
        justifyContent: 'center',
        alignItems: 'flex-end',
    },

    top: {
        flex: 12,
        flexDirection: 'row',
        backgroundColor: 'red'
    },     

    headTitle: {
        marginTop: 20,
        marginLeft: 15,
        fontSize: 20,
        fontWeight: 'bold',
    },

    subTitle: {
        marginTop: 5,
        marginLeft: 15,
        color: '#9B9B9B',
    },

    bottom: {
        flex: 20,
        backgroundColor: 'yellow',
    },
})