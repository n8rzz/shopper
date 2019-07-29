import React from 'react';
import PropTypes from 'prop-types';
import { FilterBarItem } from './filter-bar-item.component';

export class FilterBar extends React.PureComponent {
    constructor(props) {
        super(props);

        this._onChangeFilterHandler = this._onChangeFilter.bind(this);
        this.state = {
            activeFilter: props.initialSelection,
        };
    }

    _onChangeFilter(event) {
        const nextFilterSelection = event.target.text;

        this.setState({ activeFilter: nextFilterSelection }, this.props.onChangeFilterHandler(event));
    }

    render() {
        return (
            <ul className={'filterBar'}>
                {this.props.items.map((filterBarItem, index) => {
                    const isActive = this.state.activeFilter === filterBarItem.text;

                    return (
                        <FilterBarItem
                            key={`filterBar-item-${index}`}
                            isActive={isActive}
                            text={filterBarItem.text}
                            url={filterBarItem.url}
                            onChangeFilterHandler={this._onChangeFilterHandler}
                        />
                    );
                })}
            </ul>
        );
    }
}

FilterBar.propTypes = {
    items: PropTypes.array.isRequired,
    initialSelection: PropTypes.string.isRequired,
    onChangeFilterHandler: PropTypes.func,
};

FilterBar.defaultProps = {
    onChangeFilterHandler: () => {},
};
