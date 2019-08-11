import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';

import { AssemblyItem } from '../assembly-item.component';
import { assemblyMock } from '../../__mocks__/assembly.mock';
import { assemblyItemsGroupedByAssemblyIdMock } from '../../__mocks__/assembly-item.mocks';
import { departmentMapMock } from '../../__mocks__/department.mock';
import { itemMapMock } from '../../__mocks__/item.mock';

describe('AssemblyItem', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<AssemblyItem
            assembly={assemblyMock}
            assemblyItemsGroupedByAssemblyId={assemblyItemsGroupedByAssemblyIdMock}
            departmentIdMap={departmentMapMock}
            isAssemblyItemSubmitSuccess={false}
            isOpen={false}
            isSubmitAssemblySuccess={false}
            isSubmittingAssembly={false}
            itemIdMap={itemMapMock}
            onClickAccordionTriggerHandler={sinon.spy()}
            onClickAddAssemblyHandler={sinon.spy()}
            onClickAddAssemblyItemHandler={sinon.spy()}
            submittedAssemblyItemId={-1}
        />);

        expect(component).toMatchSnapshot();
    });

    describe('when `isSubmittingAssembly` is true', () => {
        let component = null;
        let assemblyBtn = null;

        beforeEach(() => {
            component = shallow(<AssemblyItem
                assembly={assemblyMock}
                assemblyItemsGroupedByAssemblyId={assemblyItemsGroupedByAssemblyIdMock}
                departmentIdMap={departmentMapMock}
                isAssemblyItemSubmitSuccess={false}
                isOpen={false}
                isSubmitAssemblySuccess={false}
                isSubmittingAssembly={true}
                itemIdMap={itemMapMock}
                onClickAccordionTriggerHandler={sinon.spy()}
                onClickAddAssemblyHandler={sinon.spy()}
                onClickAddAssemblyItemHandler={sinon.spy()}
                submittedAssemblyItemId={-1}
            />);
            assemblyBtn = component.find(`.js-assembly-${assemblyMock.id} button`);
        });

        afterEach(() => {
            component = null;
            assemblyBtn = null;
        });

        test('should render the correct text', () => {
            expect(assemblyBtn.text()).toBe('Adding...');
        });

        test('should render with the correct classnames', () => {
            expect(assemblyBtn.hasClass('mix-btn_isLoading')).toBe(true);
        });
    });

    describe('when `isSubmitAssemblySuccess` is true', () => {
        let component = null;
        let assemblyBtn = null;

        beforeEach(() => {
            component = shallow(<AssemblyItem
                assembly={assemblyMock}
                assemblyItemsGroupedByAssemblyId={assemblyItemsGroupedByAssemblyIdMock}
                departmentIdMap={departmentMapMock}
                isAssemblyItemSubmitSuccess={false}
                isOpen={false}
                isSubmitAssemblySuccess={true}
                isSubmittingAssembly={false}
                itemIdMap={itemMapMock}
                onClickAccordionTriggerHandler={sinon.spy()}
                onClickAddAssemblyHandler={sinon.spy()}
                onClickAddAssemblyItemHandler={sinon.spy()}
                submittedAssemblyItemId={-1}
            />);
            assemblyBtn = component.find(`.js-assembly-${assemblyMock.id} button`);
        });

        afterEach(() => {
            component = null;
            assemblyBtn = null;
        });

        test('should render the correct text', () => {
            expect(assemblyBtn.text()).toBe('Success!');
        });

        test('should render with the correct classnames', () => {
            expect(assemblyBtn.hasClass('mix-btn_isSuccess')).toBe(true);
        });
    });

    describe('when `submittedAssemblyItemId` is not -1', () => {
        let component = null;
        let assemblyItemBtn = null;

        beforeEach(() => {
            component = shallow(<AssemblyItem
                assembly={assemblyMock}
                assemblyItemsGroupedByAssemblyId={assemblyItemsGroupedByAssemblyIdMock}
                departmentIdMap={departmentMapMock}
                isAssemblyItemSubmitSuccess={false}
                isOpen={false}
                isSubmitAssemblySuccess={false}
                isSubmittingAssembly={false}
                itemIdMap={itemMapMock}
                onClickAccordionTriggerHandler={sinon.spy()}
                onClickAddAssemblyHandler={sinon.spy()}
                onClickAddAssemblyItemHandler={sinon.spy()}
                submittedAssemblyItemId={1}
            />);
            assemblyItemBtn = component.find(`.js-assemblyItem-${assemblyMock.id} button`);
        });

        afterEach(() => {
            component = null;
            assemblyItemBtn = null;
        });

        test('should render the correct text', () => {
            expect(assemblyItemBtn.text()).toBe('Adding...');
        });

        test('should render with the correct classnames', () => {
            expect(assemblyItemBtn.hasClass('mix-btn_isLoading')).toBe(true);
        });
    });

    describe('when `isAssemblyItemSubmitSuccess` is true', () => {
        let component = null;
        let assemblyItemBtn = null;

        beforeEach(() => {
            component = shallow(<AssemblyItem
                assembly={assemblyMock}
                assemblyItemsGroupedByAssemblyId={assemblyItemsGroupedByAssemblyIdMock}
                departmentIdMap={departmentMapMock}
                isAssemblyItemSubmitSuccess={true}
                isOpen={false}
                isSubmitAssemblySuccess={false}
                isSubmittingAssembly={false}
                itemIdMap={itemMapMock}
                onClickAccordionTriggerHandler={sinon.spy()}
                onClickAddAssemblyHandler={sinon.spy()}
                onClickAddAssemblyItemHandler={sinon.spy()}
                submittedAssemblyItemId={1}
            />);
            assemblyItemBtn = component.find(`.js-assemblyItem-${assemblyMock.id} button`);
        });

        afterEach(() => {
            component = null;
            assemblyItemBtn = null;
        });

        test('should render the correct text', () => {
            expect(assemblyItemBtn.text()).toBe('Success!');
        });

        test('should render with the correct classnames', () => {
            expect(assemblyItemBtn.hasClass('mix-btn_isSuccess')).toBe(true);
        });
    });
});
