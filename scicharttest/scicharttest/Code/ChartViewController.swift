//
//  ChartViewController.swift
//  scicharttest
//
//  Created by Arkady Smirnov on 7/29/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import UIKit
import SciChart

class ChartViewController: UIViewController {
    
    // TODO: по-хорошему бы реализовать иньекцию данной проперти, но это зависит от того как вообще будут пораждаться ViewController'ы в приложении. Пока просто закрыл протоколом.
    var pointGenerator: PointGeneratorProtcol = PointGenerator()
    
    var sciChartSurface: SCIChartSurface!
    var lineDataSeries: SCIXyDataSeries!
    var lineRenderableSeries: SCIFastLineRenderableSeries!
    var lineAnnotationRelative: SCIHorizontalLineAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSurface()
        createLineDataSeries()
        createLineDataSeries()
        createRenderableSeries()
        createAnotation()
        addModifiers()
        subscribeToGenerator()
    }
    
    private func createSurface() {
        //TODO: по хорошему бы пересчитать.
        let frame = self.view.bounds
        sciChartSurface = SCIChartSurface(frame: frame)
        sciChartSurface.translatesAutoresizingMaskIntoConstraints = true
        sciChartSurface.xAxes.add(SCINumericAxis())
        sciChartSurface.yAxes.add(SCINumericAxis())
        self.view.addSubview(sciChartSurface!)
    }
    
    private func subscribeToGenerator() {
        self.pointGenerator.subscribe {
            [weak self] (x, y) in
            
            print("x:\(x) y:\(y)")
            self?.lineDataSeries.appendX(SCIGeneric(x), y: SCIGeneric(y))
            self?.sciChartSurface?.zoomExtents()
            // наверно не самый оптимальный способ отрисовки линии, но не увидел в документации более вменяемого способа сделать это из коробки. На форумах встречается решение похожей задачи через кастомизацию SCIFastLineRenderableSeries и переопределение internalDraw, но это не на час задача, как мне кажется.
            self?.sciChartSurface.annotations.clear()
            self?.lineAnnotationRelative.y1 = SCIGeneric(y)
            self?.sciChartSurface.annotations.add(self?.lineAnnotationRelative);
        }
    }
    
    private func createAnotation() {
        self.lineAnnotationRelative = SCIHorizontalLineAnnotation();
        lineAnnotationRelative.y1 = SCIGeneric(0)
        lineAnnotationRelative.coordinateMode = .absolute;
        lineAnnotationRelative.isEditable = true
    }
    
    private func createLineDataSeries() {
        lineDataSeries = SCIXyDataSeries(xType: .double, yType: .double)
        lineDataSeries.seriesName = "line series"
    }
    
    private func createRenderableSeries(){
        lineRenderableSeries = SCIFastLineRenderableSeries()
        lineRenderableSeries.dataSeries = lineDataSeries
        sciChartSurface?.renderableSeries.add(lineRenderableSeries)
    }
    
    private func addModifiers(){
        let xAxisDragmodifier = SCIXAxisDragModifier()
        xAxisDragmodifier.dragMode = .pan
        xAxisDragmodifier.clipModeX = .none
        
        let yAxisDragmodifier = SCIYAxisDragModifier()
        yAxisDragmodifier.dragMode = .pan
        
        let extendZoomModifier = SCIZoomExtentsModifier()
        let pinchZoomModifier = SCIPinchZoomModifier()
        
        let rolloverModifier = SCIRolloverModifier()
        let legend = SCILegendModifier()
        
        let groupModifier = SCIChartModifierCollection(childModifiers: [xAxisDragmodifier, yAxisDragmodifier, pinchZoomModifier, extendZoomModifier, legend, rolloverModifier])
        sciChartSurface?.chartModifiers = groupModifier
    }
}

