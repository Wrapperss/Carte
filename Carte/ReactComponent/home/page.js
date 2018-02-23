import React, { Component } from 'react';
import {
    AppRegistry,
    Platform,
    StyleSheet,
    Text,
    View,
    ScrollView
} from 'react-native';
import CarouselCell from './carouselCell'

export default class HomePage extends Component {
    render() {
        return (
            <View style={styles.container}>
                {/* <ScrollView>
                    <CarouselCell></CarouselCell>
                    <CarouselCell></CarouselCell>
                    <CarouselCell></CarouselCell>
                </ScrollView> */}

                <CarouselCell></CarouselCell>
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