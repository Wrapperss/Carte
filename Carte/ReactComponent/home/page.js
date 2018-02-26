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

export default class HomePage extends Component {
    render() {
        return (
            <View style={styles.container}>
                <ScrollView>
                    <CarouselCell></CarouselCell>
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
})

AppRegistry.registerComponent('Carte', () => HomePage)