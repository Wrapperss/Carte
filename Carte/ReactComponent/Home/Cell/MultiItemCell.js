import React, { Component, PureComponent } from 'react';
import { 
    View,
    Text,
    Image,
    StyleSheet,
    FlatList,
 } from 'react-native';
import TitleView from '../View/TitleView'

 export default class MultiItemCell extends Component {
     constructor(props) {
         super(props);

     }
     
     render() {
         return(
             <View style={styles.container}>
                <TitleView
                    headTile={'24小时热卖'}
                    subTile={'美食达人的明智之选!'}
                    ></TitleView>
                <View style={styles.bottom}>
                    <ImageList
                        data={[
                            {
                                key: 1,
                                title: '极速低温冷冻阿根廷红虾L1 2Kg',
                                price: '128 元/盒',
                                originalPrice: '原价¥168',
                            },
                            {
                                key: 2,
                                title: '极速低温冷冻阿根廷红虾L1 2Kg',
                                price: '128 元/盒',
                                originalPrice: '原价¥168',
                            },
                            {
                                key: 3,
                                title: '极速低温冷冻阿根廷红虾L1 2Kg',
                                price: '128 元/盒',
                                originalPrice: '原价¥168',
                            },
                            {
                                key: 4,
                                title: '极速低温冷冻阿根廷红虾L1 2Kg',
                                price: '128 元/盒',
                                originalPrice: '原价¥168',
                            }
                        ]}></ImageList>
                </View>
             </View>
         );
     }
 }

 const styles = StyleSheet.create({
     container: {

     },

     bottom: {
         marginTop: 5,
     }
 })

 class ImageItem extends PureComponent {

    constructor(props) {
        super(props);
        this.props.item = props.item
    }

     _onPress = ()  => {
        console.log('点击');
     };

     render() {
         return (
             <View style={listStyles.itemContainer}>
                 <Image 
                    source={{url: 'xx'}}
                    style={{
                        width: 150,
                        height: 100,
                    }}
                    ></Image>
                 <Text 
                    numberOfLines={0} 
                    style={listStyles.itemTitle}
                    >{this.props.item.title}</Text>
                <View style={{
                    flexDirection: 'row',
                    alignItems: 'flex-end',
                    marginBottom: 3
                    }}>
                    <Text
                        style={listStyles.itemPrice}
                        >{this.props.item.price}</Text>
                    <Text
                        style={listStyles.itemOriginalPrice}
                        >{this.props.item.originalPrice}</Text>
                </View>
             </View>
         );
     }
 }

 class ImageList extends PureComponent {
    constructor(props) {
        super(props);
        this.props.data = props.data
    }
    
    _keyExtractor = (item, index) => item.key;

    _renderItem = ({item, index}) => {
        return (
            <ImageItem item={item}></ImageItem>
        );
    }
    
     render() {
         return (
            <FlatList
                style={listStyles.container}
                data={this.props.data}
                renderItem={this._renderItem}
                horizontal={true}
                keyExtractor={this._keyExtractor}
                showsHorizontalScrollIndicator={false}
                />
         );
     }
 }

 const listStyles = StyleSheet.create({
     itemContainer: {
         width: 150,
         marginLeft: 10,
     },

     itemTitle: {
        marginTop: 5,
     },

     itemPrice: {
        color: '#D0021B',
     },

     itemOriginalPrice: {
        marginLeft: 5,
        fontSize: 12,
     },

     container: {

     },
 })