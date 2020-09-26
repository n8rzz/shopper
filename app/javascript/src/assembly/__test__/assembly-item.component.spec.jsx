import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';

import { AssemblyItem } from '../assembly-item.component';
import {
    assemblyMock,
    assemblyItemsGroupedByAssemblyIdMock,
    departmentMapMock,
    itemMapMock,
    recipeMock,
} from '../../__mocks__/mocks';

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
            recipe={recipeMock}
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
                recipes={recipeMock}
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
                recipes={recipeMock}
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
                recipes={recipeMock}
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
                recipes={recipeMock}
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

    describe('when `recipe` is passed as `null`', () => {
        let component = null;
        let assemblyRecipeLink = null;

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
                recipe={null}
                submittedAssemblyItemId={1}
            />);
            assemblyRecipeLink = component.find(`.qa-assemblyRecipe-${assemblyMock.id}`);
        });

        afterEach(() => {
            component = null;
            assemblyRecipeLink = null;
        });

        test('should render the correct text', () => {
            expect(assemblyRecipeLink.text()).toBe('Add Recipe');
        });
    });

    describe('when `recipe` is not passed as `null`', () => {
        let component = null;
        let assemblyRecipeLink = null;

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
                recipe={recipeMock}
                submittedAssemblyItemId={1}
            />);
            assemblyRecipeLink = component.find(`.qa-assemblyRecipe-${assemblyMock.id}`);
        });

        afterEach(() => {
            component = null;
            assemblyRecipeLink = null;
        });

        test('should render the correct text', () => {
            expect(assemblyRecipeLink.text()).toBe('Recipe');
        });
    });
});
