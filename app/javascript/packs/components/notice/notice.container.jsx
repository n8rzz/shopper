import React from 'react';
import PropTypes from 'prop-types';
import Sticky from 'react-stickynode';
import classnames from 'classnames';
import EventService from '../../service/event.service';
import { Notice } from './notice.component';
import { EVENT_NAME } from '../../constants/event-names';

const DEAFULT_REMOVAL_DELAY = 7000;

export class NoticeContainer extends React.Component {
    constructor(props) {
        super(props);

        this._timer = -1;
        this._updateNoticeVisibilityHandler = this._updateNoticeVisibility.bind(this);
        this._onTriggerNoticeHandler = this._onTriggerNotice.bind(this);
        this._onStickyStateChangeHandler = this._onStickyStateChange.bind(this);
        this.state = {
            message: props.message,
            stickyHeaderClassnames: 'js-notice',
        };

        EventService.on(EVENT_NAME.NOTICE_SUCCESS, this._onTriggerNoticeHandler);
    }

    componentDidMount() {
        if (this.props.message == null) {
            return;
        }

        this._registerRemovalTimer();
    }

    componentWillUnmount() {
        clearTimeout(this._timer);
        EventService.off(EVENT_NAME.NOTICE_SUCCESS, this._onTriggerNoticeHandler);
    }

    _buildClassnames(status = -1) {
        return classnames({
            'js-notice': true,
            'mix-stickyHeader_isSticky': this.state.message !== '' && status === 2,
        });
    }

    _registerRemovalTimer() {
        this._timer = setTimeout(this._updateNoticeVisibilityHandler, DEAFULT_REMOVAL_DELAY);
    }

    _onStickyStateChange(event) {
        const stickyHeaderClassnames = this._buildClassnames(event.status);

        this.setState({ stickyHeaderClassnames });
    }

    _onTriggerNotice(message) {
        this.setState({ message }, this._registerRemovalTimer);
    }


    _updateNoticeVisibility() {
        this.setState({
            message: '',
            stickyHeaderClassnames: this._buildClassnames(),
        });
    }

    render() {
        const message = this.state.message != null
            ? this.state.message
            : '';

        return (
            <Sticky
                enabled={true}
                top={0}
                onStateChange={this._onStickyStateChangeHandler}
            >
                <div className={this.state.stickyHeaderClassnames}>
                    <Notice message={message} isVisible={this.state.message !== ''} />
                </div>
            </Sticky>
        );
    }
}

NoticeContainer.propTypes = {
    message: PropTypes.string,
};

NoticeContainer.defaultProps = {
    message: '',
};
